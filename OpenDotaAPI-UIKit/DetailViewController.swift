//
//  DetailViewController.swift
//  OpenDotaAPI-UIKit
//
//  Created by Juan Reyes on 5/31/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var heroImage: UIImageView!
    @IBOutlet var heroName: UILabel!
    
    var name = ""
    var hero: HeroElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heroName.text = name

    }

}
