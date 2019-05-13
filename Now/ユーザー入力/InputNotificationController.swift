//
//  InputNotificationController.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/11.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications
protocol TellDismissFirstNoticeDelegate: class {
    func tellDismissFirstNotification()
    
}
class InputNotificationController: UIViewController, UITextFieldDelegate {
    weak var delegate: TellDismissFirstNoticeDelegate?
    let inputNotificationView = InputNotificationView.instance()
    let habitModel = HabitModel()
    let datePickerView:UIDatePicker = UIDatePicker()
    var sendHours = 0
    var sendMiunte = 0
    var configPage = false
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputNotificationView.frame = self.view.frame
        self.view.addSubview(inputNotificationView)
        inputNotificationView.setUpUi()
        if configPage == false {
            inputNotificationView.notdisplayCancelButton()
        } else {
            inputNotificationView.notDisplayLaterButton()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allowNotice()
        }
        inputNotificationView.alarmTextField.delegate = self
        inputNotificationView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        inputNotificationView.laterButton.addTarget(self, action: #selector(laterButtonTapped), for: .touchUpInside)
        inputNotificationView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        inputNotificationView.notNoticeButton.addTarget(self, action: #selector(notNoticeButtonTapped), for: .touchUpInside)
        
        inputNotificationView.toolBar = UIToolbar()
        inputNotificationView.toolBar.sizeToFit()
        let toolBarBtn = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(doneBtn))
        inputNotificationView.toolBar.items = [toolBarBtn]
        inputNotificationView.alarmTextField.inputAccessoryView = inputNotificationView.toolBar
        datePickerView.datePickerMode = UIDatePicker.Mode.time
        datePickerView.locale = Locale(identifier: "ja")
        inputNotificationView.alarmTextField.inputView = datePickerView
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if configPage == true {
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                
                switch settings.authorizationStatus {
                case .authorized:
                    print("Allow notification")
                case .denied:
                    print("Denied notification")
                    self.sendIphoneConfigPage()
                case .notDetermined:
                    print("Not settings")
                    self.sendIphoneConfigPage()
                case .provisional:
                    print("??")
                }
            }
        }
    }
    @objc func nextButtonTapped() {
        if inputNotificationView.alarmTextField.text != "" {
            let realm = try! Realm()
            let similarHabit = realm.objects(SimilarHabitData.self).last
            let habit = realm.objects(HabitData.self).filter("habitNum == \(similarHabit!.currentHabitNum)").first
            try! realm.write {
                habit?.noticeHour = self.sendHours
                habit?.noticeMinute = self.sendMiunte
            }
            inputNotificationView.animationStart(xPar: (self.view.bounds.width-45)/2, yPar: self.inputNotificationView.checkCirlce.frame.origin.y) {
                if self.configPage == false {
                    self.delegate?.tellDismissFirstNotification()
                }
                self.dismiss(animated: true, completion: nil)
                self.habitModel.watchedNotificationPage()
                if self.userDefaults.object(forKey: "changePar") == nil {
                    let dict = ["changePar": true]
                    self.userDefaults.register(defaults: dict)
                } else {
                    self.userDefaults.set(true, forKey: "changePar")
                }
            }
        } else {
            sendAlert()
        }
    }
    
    @objc func laterButtonTapped() {
         self.dismiss(animated: true, completion: nil)
        let realm = try! Realm()
        let similarHabit = realm.objects(SimilarHabitData.self).last
        let habit = realm.objects(HabitData.self).filter("habitNum == \(similarHabit!.currentHabitNum)").first
        try! realm.write {
            habit?.noticeHour = 99
            habit?.noticeMinute = 99
        }
        self.habitModel.watchedNotificationPage()
    }
    
    @objc func notNoticeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
        let realm = try! Realm()
        let similarHabit = realm.objects(SimilarHabitData.self).last
        let habit = realm.objects(HabitData.self).filter("habitNum == \(similarHabit!.currentHabitNum)").first
        try! realm.write {
            habit?.noticeHour = 99
            habit?.noticeMinute = 99
        }
        self.habitModel.watchedNotificationPage()
    }
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//         if inputNotificationView.alarmTextField.text != "" {
//
//        }
//        return true
//    }
    
    @objc func doneBtn() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        inputNotificationView.alarmTextField.text = "\(formatter.string(from: datePickerView.date))"
        inputNotificationView.alarmTextField.textAlignment = .center
        inputNotificationView.alarmTextField.resignFirstResponder()
        let timeStr = (formatter.string(from: datePickerView.date))
        let prefixMoji = timeStr.prefix(2) // 先頭2文字
        let suffixMoji = timeStr.suffix(2) // 末尾2文字
        sendHours = Int(prefixMoji)!
        sendMiunte = Int(suffixMoji)!
    }
    func sendAlert() {
        let alert: UIAlertController = UIAlertController(title: "通知時間が設定されていません", message: "通知時間の選択をしてください", preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func sendIphoneConfigPage() {
        let alert: UIAlertController = UIAlertController(title: "通知が許可されていません", message: "iphoneの設定で、設定 > 通知 > アプリ > 通知を許可する必要があります。設定ページに遷移してもよろしいですか？", preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "はい", style: UIAlertAction.Style.default) { (action: UIAlertAction!) in
            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "いいえ", style: UIAlertAction.Style.cancel) { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
extension InputNotificationController: UNUserNotificationCenterDelegate {
    func allowNotice() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
            if error != nil {
                return
            }
            
            if granted {
                print("通知許可")
                let center = UNUserNotificationCenter.current()
                center.delegate = self
            } else {
                print("通知拒否")
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
}
