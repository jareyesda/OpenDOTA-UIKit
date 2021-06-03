//
//  DetailViewController.swift
//  OpenDotaAPI-UIKit
//
//  Created by Juan Reyes on 5/31/21.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var heroName: UILabel!
    @IBOutlet var heroImage: UIImageView!
    @IBOutlet var heroPrimaryAttr: UILabel!
    @IBOutlet var heroAttackType: UILabel!
    @IBOutlet var readGuideButton: UIButton!
    @IBOutlet var statsTableView: UITableView!
    
    var name = ""
    var image: UIImage?
    var primaryAttr = ""
    var attackType = ""
    var roles = [Any]()
//    var heroStats = Dictionary<String,Any>()
    
    var heroStats = [String:Any]()
    
    let webView = WKWebView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        statsTableView.delegate = self
        statsTableView.dataSource = self
        
        heroName.text = name
        heroImage.image = image
        heroPrimaryAttr.text = primaryAttr.uppercased()
        heroAttackType.text = attackType.uppercased()
        print(heroStats)
        
    }
    
    @IBAction func viewGuidePressed(_ sender: Any) {
        
        view = webView
        let url = URL(string: "https://dota2.fandom.com/wiki/\(name)/Guide")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroStats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "statsCell")!

        let stat = Array(heroStats.keys)[indexPath.row]
        let value = Array(heroStats.values)[indexPath.row]
        
        cell.textLabel?.text = stat
        cell.detailTextLabel?.text = value as? String
        
        return cell
    }

}



