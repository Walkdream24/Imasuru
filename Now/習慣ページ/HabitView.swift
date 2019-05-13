//
//  HabitView.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/07.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit
import MBCircularProgressBar
import RealmSwift

class HabitView: UIView {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    class func instance() -> HabitView {
        return UINib(nibName: "HabitView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! HabitView
    }

  
    
//    func setUpParameter(habitNum: Int) {
//        let realm = try! Realm()
//        let habit = realm.objects(HabitData.self).filter("habitNum == \(habitNum)").first
//
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.minimumLineHeight = ceil(userGoalTitle.font.lineHeight) // 行の高さの最小値
//        paragraphStyle.maximumLineHeight = ceil(userGoalTitle.font.lineHeight) // 行の高さの最大値
//        paragraphStyle.lineSpacing = ceil(userGoalTitle.font.pointSize / 2) // 行と行の間隔
//
//        let attributes = [
//            NSAttributedString.Key.paragraphStyle: paragraphStyle,
//            ]
//        let attributedText = NSAttributedString(string: habit!.goalName, attributes: attributes as [NSAttributedString.Key : Any])
//        userGoalTitle.attributedText = attributedText
//        userGoalTitle.numberOfLines = 0 // 複数行の設定
//        userGoalTitle.textAlignment = .center
////        userGoalTitle.lineBreakMode = NSLineBreakMode.byWordWrapping // 複数行のとき、単語単位で折り返す
//
//        progressLabel.text = "\(habit!.currentGoalNum)"
//        registerTimeLabel.text = registerNoticeTime()
//
//    }
//
//    func zeroValueOfCircleProgress(habitNum: Int) {
//        let realm = try! Realm()
//        let habit = realm.objects(HabitData.self).filter("habitNum == \(habitNum)").first
//        circleProgress.maxValue =  CGFloat((habit?.dateToGoal)!)
//        circleProgress.value =  0
//    }
//    func currentValueOfCircleProgress(habitNum: Int) {
//        let realm = try! Realm()
//        let habit = realm.objects(HabitData.self).filter("habitNum == \(habitNum)").first
//        UIView.animate(withDuration: 1.0) {
//            self.circleProgress.maxValue = CGFloat((habit?.dateToGoal)!)
//            self.circleProgress.value = CGFloat((habit?.currentGoalNum)!)
//        }
//    }
    //もし目標を達成していなかったらUI
//    func judgeUi() {
//        let userDefaults = UserDefaults.standard
//        if userDefaults.bool(forKey: "firstTapped") == true {
//            print("グレー")
//            noAchieveLabel.isHidden = false
//            progressLabel.textColor = UIColor(hex: "A9A9A9")
//            userGoalTitle.textColor = UIColor(hex: "A9A9A9")
//        } else {
//            print("ブラック")
//            noAchieveLabel.isHidden = true
//            progressLabel.textColor = UIColor(hex: "201E1F")
//            userGoalTitle.textColor = UIColor(hex: "201E1F")
//        }
//    }
//
//    //ボタンを押して上昇した時
    func increaseValue(habitNum: Int) {
        let realm = try! Realm()
        let habit = realm.objects(HabitData.self).filter("habitNum == \(habitNum)").first
        let similarHabit = realm.objects(SimilarHabitData.self).last
        try! realm.write {
            habit?.currentGoalNum = habit!.currentGoalNum + 1
            habit?.continuousDay = habit!.continuousDay + 1
            similarHabit?.totalHabitAchieveDay = similarHabit!.totalHabitAchieveDay + 1
        }
    }

//
    //取り消して減少した時
    func decreaseValue(habitNum: Int) {
        let realm = try! Realm()
        let habit = realm.objects(HabitData.self).filter("habitNum == \(habitNum)").first
        let similarHabit = realm.objects(SimilarHabitData.self).last
        try! realm.write {
            habit?.currentGoalNum = habit!.currentGoalNum - 1
            habit?.continuousDay = habit!.continuousDay - 1
            similarHabit?.totalHabitAchieveDay = similarHabit!.totalHabitAchieveDay - 1
        }
    }
    
    func registerNoticeTime() -> String {
        let realm = try! Realm()
        let similarHabit = realm.objects(SimilarHabitData.self).last
        let habit = realm.objects(HabitData.self).filter("habitNum == \(similarHabit!.currentHabitNum)").first
        if habit?.noticeHour != 99 && habit?.noticeMinute != 99 {
            if habit!.noticeMinute < 10 {
                return "\(habit!.noticeHour):0\(habit!.noticeMinute)から"
            } else {
                return "\(habit!.noticeHour):\(habit!.noticeMinute)から"
            }
        } else {
            return "時間が設定されていません"
        }
    }
    //習慣達成数に応じて褒めごとば投げる
    func givePraise() -> String {
        let realm = try! Realm()
        let similarHabit = realm.objects(SimilarHabitData.self).last
        if similarHabit?.totalHabitAchieveDay == 3 {
            return "もう三日坊主だなんて誰にも言わせない。"
        } else if similarHabit?.totalHabitAchieveDay == 5 {
            return "伸び代ですねええ"
        } else if similarHabit?.totalHabitAchieveDay == 10 {
            return "もう10日経ったよ、イケてる"
        } else if similarHabit?.totalHabitAchieveDay == 15 {
            return "30日まであと半分"
        } else if similarHabit?.totalHabitAchieveDay == 20 {
            return "眩しい、あなたの未来が"
        } else if similarHabit?.totalHabitAchieveDay == 25 {
            return "もう前しか見えない、成功する姿しか見えない。"
        } else if similarHabit?.totalHabitAchieveDay == 30 {
            return "最高"
        } else if similarHabit?.totalHabitAchieveDay == 35 {
            return "まだ高みを目指すか、、あなたには敵わねえ。"
        } else if similarHabit?.totalHabitAchieveDay == 40 {
            return "ああ、もうトータルで40日、夏休み超えたね"
        } else if similarHabit?.totalHabitAchieveDay == 50 {
            return "50！！半端ないって"
        } else if similarHabit?.totalHabitAchieveDay == 60 {
            return "とうとう60日、、強い。"
        } else if similarHabit?.totalHabitAchieveDay == 70 {
            return "100日目指しちゃおう"
        } else if similarHabit?.totalHabitAchieveDay == 80 {
            return "もう当たり前だね、、"
        } else if similarHabit?.totalHabitAchieveDay == 90 {
            return "ここまで来たか、、"
        } else if similarHabit?.totalHabitAchieveDay == 100 {
            return "100日！！もう習慣のプロフェッショナル"
        } else if similarHabit?.totalHabitAchieveDay == 120 {
            return "一体どこまで行くんだ、、、早すぎる。"
        } else if similarHabit?.totalHabitAchieveDay == 150 {
            return "すごい。"
        } else if similarHabit?.totalHabitAchieveDay == 200 {
            return "200! 誇りです！！"
        } else {
            return ""
        }
    }
}
