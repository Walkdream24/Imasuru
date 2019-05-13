//
//  HabitNameTableViewCell.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/30.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit
import RealmSwift

class HabitNameTableViewCell: UITableViewCell {
    @IBOutlet weak var notRegisterTimeLabel: UILabel!
    @IBOutlet weak var userGoalLabel: UILabel!
    @IBOutlet weak var notAchieveLabel: UILabel!
    let habitModel = HabitModel()
    var currentHabitNum = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        let realm = try! Realm()
//        let habit = realm.objects(HabitData.self).filter("habitNum == \(currentHabitNum)").first
//        currentHabitNum = habitModel.currentHabitNum()
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.minimumLineHeight = ceil(userGoalLabel.font.lineHeight) // 行の高さの最小値
//        paragraphStyle.maximumLineHeight = ceil(userGoalLabel.font.lineHeight) // 行の高さの最大値
//        paragraphStyle.lineSpacing = ceil(userGoalLabel.font.pointSize / 2) // 行と行の間隔
//        
//        let attributes = [
//            NSAttributedString.Key.paragraphStyle: paragraphStyle,
//        ]
//        letattributedText = NSAttributedString(string: habit!.goalName, attributes: attributes as [NSAttributedString.Key : Any])
//        userGoalLabel.attributedText = attributedText
//        userGoalLabel.numberOfLines = 0 // 複数行の設定
//        userGoalLabel.textAlignment = .center
        
    }

    
}
