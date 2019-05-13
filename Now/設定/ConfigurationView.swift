//
//  ConfigurationView.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/07.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit
import RealmSwift

class ConfigurationView: UIView {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    class func instance() -> ConfigurationView {
        return UINib(nibName: "ConfigurationView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! ConfigurationView
    }
    func registerNoticeTime() -> String {
        let realm = try! Realm()
        let similarHabit = realm.objects(SimilarHabitData.self).last
        let habit = realm.objects(HabitData.self).filter("habitNum == \(similarHabit!.currentHabitNum)").first
        if habit?.noticeHour != 99 && habit?.noticeMinute != 99 {
            if habit!.noticeMinute < 10 {
                return "\(habit!.noticeHour):0\(habit!.noticeMinute)"
            } else {
                return "\(habit!.noticeHour):\(habit!.noticeMinute)"
            }
        } else {
            return "登録されていません"
        }
    }
    
}
