//
//  ConfigurationTableViewCell.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/07.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit

class ConfigurationTableViewCell: UITableViewCell {

    @IBOutlet weak var configLabel: UILabel!
    @IBOutlet weak var configContentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
