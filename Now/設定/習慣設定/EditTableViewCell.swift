//
//  EditTableViewCell.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/12.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit

class EditTableViewCell: UITableViewCell {

    @IBOutlet weak var configNameLabel: UILabel!
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
