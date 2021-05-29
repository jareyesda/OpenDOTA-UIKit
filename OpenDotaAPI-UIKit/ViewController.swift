//
//  ViewController.swift
//  OpenDotaAPI-UIKit
//
//  Created by Juan Reyes on 5/27/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    let apiURL = "https://api.opendota.com/api/herostats#"
    let imageCache = NSCache<NSString, UIImage>()

    
//    let imageCache = NSCache<NSString, HeroElement>()
    
    
    var fetchedData = [HeroElement]()
    var heroIcons = [UIImage]()
    
    @IBOutlet var heroTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        heroTableView.dataSource = self
        
        parseData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (fetchedData.count - 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = heroTableView.dequeueReusableCell(withIdentifier: "heroCell")
        
        let name = fetchedData[indexPath.row].name
        cell?.textLabel?.text = name
        
//        let image = heroIcons[indexPath.row]
//        cell?.imageView?.image = image
        
        let iconURL = fetchedData[indexPath.row].icon
//        let url = URL(string: "https://api.opendota.com\(iconURL)")
//        let url = "https://api.opendota.com\(iconURL)"
        
        
        // ** This method doesn't work because it only sets icons when the cell is pressed, and they are deleted when cell is deleted.
        // ~~~~~~~~~~~~~~~~
//        cell?.imageView?.image = nil
//        cell?.tag = indexPath.row
//        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            guard let data = data, error == nil else { return }
//
//            DispatchQueue.main.async {
//                if cell!.tag == indexPath.row {
//                    cell?.imageView?.image = UIImage(data: data)
//                }
//            }
//        }
//        task.resume()
        
        // ** This method doesn't work because a network call is made everytime a cell is created. Therefore its too laggy
        // ~~~~~~~~~~~~~~~~
        
//        if let data = try? Data(contentsOf: url!) {
//            let heroIcon = UIImage(data: data)
//            cell?.imageView?.image = heroIcon
//        } else {
//            cell?.imageView?.image = nil
//        }//make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        
        

//        DispatchQueue.global().async {
//            let data = try? Data(contentsOf: url!)
//            DispatchQueue.main.async {
//                if let heroIcon = UIImage(data: data!) {
//                    cell?.imageView?.image = heroIcon
//                }
//            }
//        }
        
        // This doesn't work because the app crashes when the last cell is reached/created
        // ~~~~~~~~~~~~~~~~ 
        DispatchQueue.global(qos: .background).async {
            let url = URL(string: "https://api.opendota.com\(iconURL)")
            let data = try? Data(contentsOf: url!)
            if let image = UIImage(data: data!) {
                DispatchQueue.main.async {
                    self.imageCache.setObject(image, forKey: NSString(string: self.fetchedData[indexPath.row].name))
                    cell?.imageView?.image = image
                }
            } else {
                cell?.imageView?.image = nil
            }
        }
        
//        cell?.imageView?.loadImageUsingCache(withUrl: url)
        
        
        return cell!
    }
    
    func parseData() {
        
        fetchedData = []
        heroIcons = []
        
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
                            self.heroIcons.append(image!)
                        }
                        
                        self.fetchedData.append(HeroElement(id: id, name: name, primaryAttr: PrimaryAttr(rawValue: primaryAttr)!, attackType: AttackType(rawValue: attackType)!, roles: roles, img: img, icon: icon, baseHealth: baseHealth, baseHealthRegen: baseHealthRegen as? Double, baseMana: baseMana, baseManaRegen: baseManaRegen, baseArmor: baseArmor, baseMr: baseMr, baseAttackMin: baseAttackMin, baseAttackMax: baseAttackMax, baseStr: baseStr, baseAgi: baseAgi, baseInt: baseInt, strGain: strGain, agiGain: agiGain, intGain: intGain, attackRange: attackRange, projectileSpeed: projectileSpeed, attackRate: attackRate, moveSpeed: moveSpeed, turnRate: turnRate ?? 0))
                        
                    }
                    
                    print(self.heroIcons.count)
                    print(self.fetchedData.count)
                    self.heroTableView.reloadData()
                    
                    
                } catch {
                    print("Ahhh")
                }
            }
            
        }
        
        task.resume()
        
    }
    
}

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        if url == nil {return}
        self.image = nil

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }

        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }

        }).resume()
    }
}
