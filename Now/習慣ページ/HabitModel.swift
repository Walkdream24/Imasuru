//
//  HabitModel.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/08.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import Foundation
import RealmSwift

class HabitModel {
    //現在行なっている習慣の番号
    func currentHabitNum() -> Int {
        let realm = try! Realm()
        let similarHabit = realm.objects(SimilarHabitData.self).last
        return similarHabit!.currentHabitNum
    }
    
    //習慣をスタートした日が登録されていなかった場合
    func saveFirstDay(habitNum: Int) {
        let timeModel = TimeDataModel()
        let realm = try! Realm()
        let habit = realm.objects(HabitData.self).filter("habitNum == \(habitNum)").first
        try! realm.write {
            habit?.startDay = timeModel.registerDay()
        }
    }
    
    //習慣を達成した日を登録
    func saveFinishDay(habitNum: Int) {
        let timeModel = TimeDataModel()
        let realm = try! Realm()
        let habit = realm.objects(HabitData.self).filter("habitNum == \(habitNum)").first
        try! realm.write {
            habit?.finishDay = timeModel.registerDay()
        }
    }
    
    //習慣をその日達成した時の時刻（hour）を登録
    func registerHourOfButtonTapped(habitNum: Int) {
        let timeModel = TimeDataModel()
        let realm = try! Realm()
        let habit = realm.objects(HabitData.self).filter("habitNum == \(habitNum)").first
        try! realm.write {
            habit?.firstButtonTappedHour = timeModel.setIntHour()
        }
    }
    
    
    //リセット時刻を登録（0時より前だったら次の日のam3時 0時以降3時未満ならその日の3時にリセット）
    func registerResetTime(habitNum: Int) {
        let timeModel = TimeDataModel()
        let realm = try! Realm()
        let habit = realm.objects(HabitData.self).filter("habitNum == \(habitNum)").first
        if habit!.firstButtonTappedHour >= 0 && habit!.firstButtonTappedHour < 3 {
            try! realm.write {
                habit?.firstButtonTappedTime = timeModel.setResetTimeafter12()
            }
        } else {
            try! realm.write {
                habit?.firstButtonTappedTime = timeModel.setResetTimebefore12()
            }
        }
    }
    
    //継続リセット
    func resetOfContinuous(habitNum: Int) {
        let realm = try! Realm()
        let habit = realm.objects(HabitData.self).filter("habitNum == \(habitNum)").first
        try! realm.write {
            habit?.continuousDay = 0
        }
    }
    
    //新たな習慣を設置する際にcurrentHabitNumの値を1増やす
    func addCurrentHabitNum() {
        let realm = try! Realm()
        let similarHabit = realm.objects(SimilarHabitData.self).last
        try! realm.write {
            similarHabit?.currentHabitNum = similarHabit!.currentHabitNum + 1
        }
    }
    
    //通知の時間(hour)
    func noticeHour() -> Int {
        let realm = try! Realm()
        let similarHabit = realm.objects(SimilarHabitData.self).last
        let habit = realm.objects(HabitData.self).filter("habitNum == \(similarHabit!.currentHabitNum)").first
        return habit!.noticeHour
    }
    //通知の時間(minute)
    func noticeMinute() -> Int {
        let realm = try! Realm()
        let similarHabit = realm.objects(SimilarHabitData.self).last
        let habit = realm.objects(HabitData.self).filter("habitNum == \(similarHabit!.currentHabitNum)").first
        return habit!.noticeMinute
    }
    
    
    //通知画面を表示したあとBool値をtrueに登録
    func watchedNotificationPage() {
        let realm = try! Realm()
        let similarHabit = realm.objects(SimilarHabitData.self).last
        let habit = realm.objects(HabitData.self).filter("habitNum == \(similarHabit!.currentHabitNum)").first
        try! realm.write {
            habit?.notificationPage = true
        }
    }
    
}
