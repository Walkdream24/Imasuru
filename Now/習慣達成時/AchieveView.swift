//
//  AchieveView.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/08.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit
import RealmSwift

class AchieveView: UIView {
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var goalLabel: UILabel!
    class func instance() -> AchieveView{
        return UINib(nibName: "AchieveView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! AchieveView
    }
    func setUpUi() {
        dismissButton.layer.cornerRadius = 25
        let realm = try! Realm()
        let similarHabit = realm.objects(SimilarHabitData.self).last
        let habit = realm.objects(HabitData.self).filter("habitNum == \(similarHabit!.currentHabitNum)").first
        let text = "30日間、「\(habit!.goalName)」を達成しました。おめでとうございます！この度はアプリを使っていただきありがとうございました。もうアプリを使わなくても習慣化していると思います。それでも今後使って頂けると嬉しいです！レビューでのご意見お待ちしております！!"
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = ceil(goalLabel.font.lineHeight) // 行の高さの最小値
        paragraphStyle.maximumLineHeight = ceil(goalLabel.font.lineHeight) // 行の高さの最大値
        paragraphStyle.lineSpacing = ceil(goalLabel.font.pointSize / 2) // 行と行の間隔
        
        let attributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            ]
        let attributedText = NSAttributedString(string: text, attributes: attributes as [NSAttributedString.Key : Any])
        goalLabel.attributedText = attributedText
        
        goalLabel.numberOfLines = 0 // 複数行の設定
        goalLabel.lineBreakMode = NSLineBreakMode.byWordWrapping // 複数行のとき、単語単位で折り返す
        goalLabel.sizeToFit() // 最適なサ
        
    }
}
