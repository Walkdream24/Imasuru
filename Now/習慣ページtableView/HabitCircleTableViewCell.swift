//
//  HabitCircleTableViewCell.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/30.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class HabitCircleTableViewCell: UITableViewCell {
    @IBOutlet weak var cirularProgressBar: MBCircularProgressBarView!
    @IBOutlet weak var currentGoalNum: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
