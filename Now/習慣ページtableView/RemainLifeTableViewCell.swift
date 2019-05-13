//
//  RemainLifeTableViewCell.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/30.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit

class RemainLifeTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
