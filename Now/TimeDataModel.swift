//
//  TimeDataModel.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/08.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import Foundation
import RealmSwift

class TimeDataModel {
    //初めて目標を達成した日にちまたは習慣を終了した日にちを登録
    func registerDay() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: Locale(identifier: "ja_JP"))
        print(formatter.string(from: now))
        return formatter.string(from: now)
    }
    
    //ボタンを押した時の時刻を設定
    func setIntHour() -> Int {
        let now = Date()
        return now.hour
    }
    //ボタンを押した時刻から1日のリセット時刻を設定(12時以降の場合
    func setResetTimeafter12() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd HH:mm", options: 0, locale: Locale(identifier: "ja_JP"))
        let resetTime = Date(year: now.year, month: now.month, day: now.day, hour: 3, minute: 0, second: 0)
        return formatter.string(from: resetTime)
    }
    //ボタンを押した時刻から1日のリセット時刻を設定(12時より前の場合
    func setResetTimebefore12() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd HH:mm", options: 0, locale: Locale(identifier: "ja_JP"))
        let resetTime = Date(year: now.year, month: now.month, day: now.day, hour: 27, minute: 0, second: 0)
        return formatter.string(from: resetTime)
    }
    
    //習慣の画面に遷移した時リセットの時間になっているか判定
    func judgeResetTime(habitNum: Int,completion: @escaping () -> Void) {
        let now = Date()
        let formatter = DateFormatter()
        let userDefaults = UserDefaults.standard
        let realm = try! Realm()
        let habit = realm.objects(HabitData.self).filter("habitNum == \(habitNum)").first
        guard habit?.firstButtonTappedTime != "" else {
            return
        }
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd HH:mm", options: 0, locale: Locale(identifier: "ja_JP"))
        let registerTime = formatter.date(from: habit!.firstButtonTappedTime)
        if now < registerTime! {
            print("まだリセット時間ではありません")
        } else if now == registerTime! {
            print("ちょうどリセットタイム")
            userDefaults.set(true, forKey: "firstTapped")
        } else if now > registerTime! {
            print("リセット時間を迎えています")
            userDefaults.set(true, forKey: "firstTapped")
        }
        completion()
    }
    
    //継続しているかどうか判定
    func judgeOfContinuous(habitNum: Int) {
        let userDefaults = UserDefaults.standard
        guard userDefaults.bool(forKey: "firstTapped") == true else {
            print("すでにボタンは押されているので継続判定は不要です")
            return
        }
        let now = Date()
        let formatter = DateFormatter()
        let realm = try! Realm()
        let habitModel = HabitModel()
        let habit = realm.objects(HabitData.self).filter("habitNum == \(habitNum)").first
        guard habit?.firstButtonTappedTime != "" else {
            return
        }
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let registerTime = formatter.date(from: habit!.firstButtonTappedTime)
        let endDate = registerTime!.addingTimeInterval(86400)
        let dateInterval = DateInterval(start: registerTime!, end: endDate)
        print(dateInterval.start)
        print(dateInterval.end)
        if now >= dateInterval.start && now < dateInterval.end {
            print("まだセーフ")
        } else if now < dateInterval.start {
            print("まだセーフ")
        } else {
            print("アウト継続リセット")
            habitModel.resetOfContinuous(habitNum: habitNum)
        }
    }
    
    
    
    
}
