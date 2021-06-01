//
//  DetailViewController.swift
//  OpenDotaAPI-UIKit
//
//  Created by Juan Reyes on 5/31/21.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    
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
    var heroStats = Dictionary<String,String>()
    
    let webView = WKWebView()
    
    @IBOutlet var heroCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        heroName.text = name
        heroImage.image = image
        heroPrimaryAttr.text = primaryAttr
        heroAttackType.text = attackType
        print(roles)
        
    }
    
    @IBAction func viewGuidePressed(_ sender: Any) {
        
        view = webView
        let url = URL(string: "https://dota2.fandom.com/wiki/\(name)")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
    }

}



