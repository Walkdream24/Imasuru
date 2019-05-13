//
//  UserDataModel.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/08.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import Foundation
import RealmSwift

class UserDataModel {
    
    //1つの習慣を登録
    func initHabit(goalName: String, habitNum: Int) {
        let realm = try! Realm()
        let habit = HabitData()
        habit.goalName = goalName
        habit.currentGoalNum = 0
        habit.dateToGoal = 30
        habit.continuousDay = 0
        habit.noticeHour = 99
        habit.noticeMinute = 99
        habit.startDay = ""
        habit.finishDay = ""
        habit.firstButtonTappedTime = ""
        habit.firstButtonTappedHour = 000
        habit.habitNum = habitNum
        habit.notificationPage = false
        try! realm.write {
            realm.add(habit)
        }
    }
    
    //共通の習慣データ
    func initSimilarHabit(currentHabitNum: Int) {
        let realm = try! Realm()
        let similarHabit = SimilarHabitData()
        similarHabit.currentHabitNum = currentHabitNum
        similarHabit.totalHabitAchieveDay = 0
        similarHabit.bestContinuousDay = 0
        try! realm.write {
            realm.add(similarHabit)
        }
    }
    
    //特定の削除
    func deleteHabit(habitNum: Int) {
        let realm = try! Realm()
        let habit = realm.objects(HabitData.self).filter("habitNum == \(habitNum)")
        
        try! realm.write {
            realm.delete(habit)
        }
    }
    //全て削除
    func allDeleteHabit() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
   
}



