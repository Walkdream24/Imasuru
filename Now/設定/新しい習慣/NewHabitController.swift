//
//  NewHabitController.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/12.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit

class NewHabitController: UIViewController, UITextFieldDelegate {
    let newHabitView = InputView.instance()
    var userGoalText = ""
    let userDataModel = UserDataModel()
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newHabitView.frame = self.view.frame
        self.view.addSubview(newHabitView)
        newHabitView.goalTextField.delegate = self
        newHabitView.firstUi()
        newHabitView.cancelButtonNotDisplay()
        newHabitView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        newHabitView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    @objc func nextButtonTapped() {
        if userGoalText != "" {
            newHabitView.animationStart(){
                
                self.userDataModel.initHabit(goalName: self.userGoalText, habitNum: 1)
//                self.userDefaults.set(false, forKey: "firstLaunch")
                self.userDefaults.set(true, forKey: "firstTapped")
                self.userDefaults.synchronize()
                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        } else {
            sendAlert()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userGoalText = newHabitView.goalTextField.text!
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userGoalText = newHabitView.goalTextField.text!
        self.view.endEditing(true)
    }

    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    func sendAlert() {
        let alert: UIAlertController = UIAlertController(title: "テキストが空です", message: "目標を入力してください", preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }

}
