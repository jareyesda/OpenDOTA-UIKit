//
//  StatsCell.swift
//  OpenDotaAPI-UIKit
//
//  Created by Juan Reyes on 6/4/21.
//

import UIKit

class StatsCell: UITableViewCell {
    
    @IBOutlet var statLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
