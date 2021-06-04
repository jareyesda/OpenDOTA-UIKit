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
        
        let cellNib = UINib(nibName: "StatsCell", bundle: nil)
        statsTableView.register(cellNib, forCellReuseIdentifier: "statsCell")
        
        statsTableView.reloadData()
                
    }
    
    @IBAction func viewGuidePressed(_ sender: Any) {
        
        var urlName = name
        
        if urlName.contains(" ") == true {
            urlName = urlName.replacingOccurrences(of: " ", with: "_")
        } else if urlName == "Nature's Prophet" {
            urlName = "Nature%27s_Prophet"
        }
        
        view = webView
        let url = URL(string: "https://dota2.fandom.com/wiki/\(urlName)/Guide")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroStats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let stats = self.heroStats.sorted(by:{
            (e1:(String,Any), e2:(String,Any)) -> Bool in
            e1.0 < e2.0
        })
        
        let stat = stats[indexPath.row].key
        let value = stats[indexPath.row].value

        let cell = tableView.dequeueReusableCell(withIdentifier: "statsCell", for: indexPath) as! StatsCell
        
        cell.statLabel.text = stat
        cell.valueLabel.text = (value as! String)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
    }

}



