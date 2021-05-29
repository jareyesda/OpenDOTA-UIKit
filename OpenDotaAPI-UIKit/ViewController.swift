//
//  ViewController.swift
//  OpenDotaAPI-UIKit
//
//  Created by Juan Reyes on 5/27/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var fetchedData = [HeroElement]()
    
    @IBOutlet var heroTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        heroTableView.dataSource = self
        
        parseData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = heroTableView.dequeueReusableCell(withIdentifier: "heroCell")
        
        cell?.textLabel?.text = fetchedData[indexPath.row].name
        
        return cell!
    }
    
    func parseData() {
        
        fetchedData = []
        
        let url = "https://api.opendota.com/api/herostats#"
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
    
    
}
