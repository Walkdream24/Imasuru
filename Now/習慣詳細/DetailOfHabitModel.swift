//
//  DetailOfHabitModel.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/10.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import Foundation
import RealmSwift

class DetailOfHabitModel {
    //全ての習慣のトータル日数
    func allHabitDays() -> Int {
        let realm = try! Realm()
        let similarHabit = realm.objects(SimilarHabitData.self).last
        return similarHabit!.totalHabitAchieveDay
    }
    //習慣の継続日数
    func continuousOfHabit() -> Int {
        let realm = try! Realm()
        let similarHabit = realm.objects(SimilarHabitData.self).last
        let habit = realm.objects(HabitData.self).filter("habitNum == \(similarHabit!.currentHabitNum)").first
        return habit!.continuousDay
    }
    
    //目標達成を取り消してスタート日が消えた場合
    func nothingStartDay(habitNum: Int) {
        let realm = try! Realm()
        let habit = realm.objects(HabitData.self).filter("habitNum == \(habitNum)").first
        try! realm.write {
            habit?.startDay = ""
        }
    }
}
