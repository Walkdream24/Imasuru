//
//  AppDelegate.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/07.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit
import GoogleMobileAds
import UserNotifications
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let userDefaults = UserDefaults.standard


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        let dict = ["firstLaunch": true]
        userDefaults.register(defaults: dict)
        if userDefaults.bool(forKey: "firstLaunch") {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name:"InputGoal", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "InputGoal")
            let navigationController = UINavigationController(rootViewController: initialViewController)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        } else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "MyTabBar", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "MyTabBar")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
      
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        //　通知設定に必要なクラスをインスタンス化
        let habitModel = HabitModel()
        var trigger: UNNotificationTrigger
        var trigger2: UNNotificationTrigger
        let content = UNMutableNotificationContent()
        let content2 = UNMutableNotificationContent()
        var notificationTime = DateComponents()
        var notificationTime2 = DateComponents()
        if habitModel.noticeHour() != 99 && habitModel.noticeMinute() != 99 {
           if userDefaults.bool(forKey: "firstTapped") == true {
                // トリガー設定
                let registerHour: Int = habitModel.noticeHour()
                let registerMiunte: Int = habitModel.noticeMinute()
                notificationTime.hour = registerHour
                notificationTime.minute = registerMiunte
                trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: true)
                // 通知内容の設定
                content.title = "習慣の時間です!今しましょう！!"
                content.body = "明日やろうはバカヤロウ"
                content.sound = UNNotificationSound.default
                content.badge = 1
                
                
                // 通知スタイルを指定
                let request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)
                // 通知をセット
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            }
        }
       if userDefaults.bool(forKey: "firstTapped") == true {
             if habitModel.noticeHour() != 99 && habitModel.noticeMinute() != 99 {
                // トリガー設定
                let registerHour: Int = habitModel.noticeHour()
                let registerMiunte: Int = habitModel.noticeMinute() + 1
                notificationTime2.hour = registerHour
                notificationTime2.minute = registerMiunte
                trigger2 = UNCalendarNotificationTrigger(dateMatching: notificationTime2, repeats: true)
                // 通知内容の設定
                content2.title = "習慣の時間を過ぎています！"
                content2.body = "明日じゃなくて今今今今今今今今今今今今今"
                content2.sound = UNNotificationSound.default
                content2.badge = 1
                // 通知スタイルを指定
                let request = UNNotificationRequest(identifier: "uuid2", content: content2, trigger: trigger2)
                // 通知をセット
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            }
            
        }
        
        
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

