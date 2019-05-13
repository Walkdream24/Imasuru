//
//  NextHabitController.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/10.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit
import RealmSwift

class NextHabitController: UIViewController, UITextFieldDelegate {
    let nextHabitView = InputView.instance()
    var userGoalText = ""
    let userDataModel = UserDataModel()
    let habitModel = HabitModel()
    let userDefaults = UserDefaults.standard
    var achievedHabit = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextHabitView.frame = self.view.frame
        self.view.addSubview(nextHabitView)
        nextHabitView.goalTextField.delegate = self
        nextHabitView.firstUi()
        if achievedHabit == true {
            nextHabitView.cancelButtonNotDisplay()
        }
        nextHabitView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextHabitView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    @objc func nextButtonTapped() {
        if userGoalText != "" {
            guard userGoalText.count <= 25 else {
                sendWordCountAlert()
                return
            }
            self.habitModel.addCurrentHabitNum()
            nextHabitView.animationStart(xPar: (self.view.bounds.width-37)/2, yPar: self.nextHabitView.circleImage.frame.origin.y) {
                let realm = try! Realm()
                let similarHabit = realm.objects(SimilarHabitData.self).last
                self.userDataModel.initHabit(goalName: self.userGoalText, habitNum: similarHabit!.currentHabitNum)
                self.userDefaults.set(true, forKey: "firstTapped")
                if self.userDefaults.object(forKey: "changePar") == nil {
                    print("登録")
                    let dict = ["changePar": true]
                    self.userDefaults.register(defaults: dict)
                } else {
                    self.userDefaults.set(true, forKey: "changePar")
                    print("登録してた")
                }
                self.dismiss(animated: true, completion: nil)
                
            }
        } else {
            sendAlert()
        }
    }
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userGoalText = nextHabitView.goalTextField.text!
        textField.resignFirstResponder()
        if userGoalText.count > 25 {
            nextHabitView.wordCountOverAnimation()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userGoalText = nextHabitView.goalTextField.text!
        if userGoalText.count > 25 {
            nextHabitView.wordCountOverAnimation()
        }
        self.view.endEditing(true)
       
    }
    
    func sendAlert() {
        let alert: UIAlertController = UIAlertController(title: "テキストが空です", message: "目標を入力してください", preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action: UIAlertAction!) in
           
        }
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    func sendWordCountAlert() {
        let alert: UIAlertController = UIAlertController(title: "文字数制限を超えています", message: "25文字以内で入力してください", preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action: UIAlertAction!) in
           
        }
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    

}
