//
//  ViewController.swift
//  OpenDotaAPI-UIKit
//
//  Created by Juan Reyes on 5/27/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // apiURL will not change
    let apiURL = "https://api.opendota.com/api/herostats#"
    
    // Data sources for our heroTableView
    let iconCache = NSCache<NSString, UIImage>()
    var fetchedData = [HeroElement]()
    
    @IBOutlet var heroTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heroTableView.dataSource = self
        heroTableView.delegate = self
        
        parseData()
        
    }
    
    //MARK: - JSON Parsing Method
    
    func parseData() {

        fetchedData = []

        let url = apiURL
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"

        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)

        let task = session.dataTask(with: request) { (data, response, error) in

            if (error != nil) {
                print(error!)
            } else {
                do {

                    let heroes = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSArray

                    for hero in heroes {
                        let eachHero = hero as! [String: Any]
                        let id = eachHero["id"] as! Int
                        let name = eachHero["localized_name"] as! String
                        let primaryAttr = eachHero["primary_attr"] as! String
                        let attackType = eachHero["attack_type"] as! String
                        let roles = eachHero["roles"] as! Array<Any>
                        let img = eachHero["img"] as! String
                        let icon = eachHero["icon"] as! String
                        let baseHealth = eachHero["base_health"] as! Int
                        let baseHealthRegen = eachHero["base_health_regen"] as? Double?
                        let baseMana = eachHero["base_mana"] as! Int
                        let baseManaRegen = eachHero["base_mana_regen"] as! Double
                        let baseArmor = eachHero["base_armor"] as! Double
                        let baseMr = eachHero["base_mr"] as! Int
                        let baseAttackMin = eachHero["base_attack_min"] as! Int
                        let baseAttackMax = eachHero["base_attack_max"] as! Int
                        let baseStr = eachHero["base_str"] as! Int
                        let baseAgi = eachHero["base_agi"] as! Int
                        let baseInt = eachHero["base_int"] as! Int
                        let strGain = eachHero["str_gain"] as! Double
                        let agiGain = eachHero["agi_gain"] as! Double
                        let intGain = eachHero["int_gain"] as! Double
                        let attackRange = eachHero["attack_range"] as! Int
                        let projectileSpeed = eachHero["projectile_speed"] as! Int
                        let attackRate = eachHero["attack_rate"] as! Double
                        let moveSpeed = eachHero["move_speed"] as! Int
                        let turnRate = eachHero["turn_rate"] as? Double?

                        let imageUrl = URL(string:"https://api.opendota.com\(icon)")
                        if let imageData = try? Data(contentsOf: imageUrl!) {
                            let image = UIImage(data: imageData)
                            self.iconCache.setObject(image!, forKey: NSString(string: (String(id))))
                        }

                        self.fetchedData.append(HeroElement(id: id, name: name, primaryAttr: PrimaryAttr(rawValue: primaryAttr)!, attackType: AttackType(rawValue: attackType)!, roles: roles, img: img, icon: icon, baseHealth: baseHealth, baseHealthRegen: baseHealthRegen as? Double, baseMana: baseMana, baseManaRegen: baseManaRegen, baseArmor: baseArmor, baseMr: baseMr, baseAttackMin: baseAttackMin, baseAttackMax: baseAttackMax, baseStr: baseStr, baseAgi: baseAgi, baseInt: baseInt, strGain: strGain, agiGain: agiGain, intGain: intGain, attackRange: attackRange, projectileSpeed: projectileSpeed, attackRate: attackRate, moveSpeed: moveSpeed, turnRate: turnRate ?? 0))

                    }

                    self.heroTableView.reloadData()


                } catch {
                    print("Ahhh")
                }
            }

        }

        task.resume()

    }
    
    //MARK: - TableView & Segue Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Loaded")
        return (fetchedData.count - 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = heroTableView.dequeueReusableCell(withIdentifier: "heroCell")
        
        let name = fetchedData[indexPath.row].name
        cell?.textLabel?.text = name
        
        let iconURL = fetchedData[indexPath.row].icon
        let url = URL(string: "https://api.opendota.com\(iconURL)")
        
        // The code below is a performance improvement. In which images are cached when loaded and persisted once loaded.
        if let cachedImage = iconCache.object(forKey: NSString(string: String(fetchedData[indexPath.row].id))) {
            cell?.imageView?.image = cachedImage
        } else {
            if let data = try? Data(contentsOf: url!) {
                let heroIcon = UIImage(data: data)
                cell?.imageView?.image = heroIcon
            } else {
                cell?.imageView?.image = nil
            }//make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showHero", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? DetailViewController {
            
            let heroIndex = heroTableView.indexPathForSelectedRow?.row
            
            destination.name = fetchedData[heroIndex!].name
            destination.primaryAttr = fetchedData[heroIndex!].primaryAttr.rawValue
            destination.attackType = fetchedData[heroIndex!].attackType.rawValue
            destination.roles = fetchedData[heroIndex!].roles
            
            let imageURL = fetchedData[heroIndex!].img
            let url = URL(string: "https://api.opendota.com\(imageURL)")
            if let data = try? Data(contentsOf: url!) {
                let heroImage = UIImage(data: data)
                destination.image = heroImage
            }
            
//            destination.heroStats =
            
            
        }
    }
    
}
