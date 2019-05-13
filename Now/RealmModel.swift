//
//  RealmModel.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/08.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import Foundation
import RealmSwift

class HabitData: Object {
    @objc dynamic var goalName: String = ""
    @objc dynamic var currentGoalNum: Int = 0
    @objc dynamic var dateToGoal: Int = 30
    @objc dynamic var continuousDay: Int = 0
    @objc dynamic var noticeHour: Int = 0
    @objc dynamic var noticeMinute: Int = 0
    @objc dynamic var startDay: String = ""
    @objc dynamic var finishDay: String = ""
    @objc dynamic var firstButtonTappedTime: String = ""
    @objc dynamic var firstButtonTappedHour: Int = 000
    @objc dynamic var notificationPage: Bool = false
    @objc dynamic var habitNum: Int = 0
}

class SimilarHabitData: Object {
    @objc dynamic var currentHabitNum: Int = 0
    @objc dynamic var totalHabitAchieveDay: Int = 0
    @objc dynamic var bestContinuousDay: Int = 0
    @objc dynamic var modalReview: Bool = false
    
}

class History: Object {
    @objc dynamic var goalName: String = ""
    @objc dynamic var period: String = ""
    @objc dynamic var currentGoalNum: Int = 0
    @objc dynamic var dateToGoal: Int = 30
    @objc dynamic var id: Int = 0
    override static func primaryKey() -> String {
        return "id"
    }
}
