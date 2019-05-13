//
//  InputGoalController.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/07.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit

class InputGoalController: UIViewController, UITextFieldDelegate {
    let inputGoalView = InputView.instance()
    var userGoalText = ""
    let userDataModel = UserDataModel()
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputGoalView.frame = self.view.frame
        self.view.addSubview(inputGoalView)
        inputGoalView.goalTextField.delegate = self
        inputGoalView.firstUi()
        inputGoalView.cancelButtonNotDisplay()
        inputGoalView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func nextButtonTapped() {
        if userGoalText != "" {
        guard userGoalText.count <= 25 else {
            sendWordCountAlert()
            return
        }
            inputGoalView.animationStart(xPar: (self.view.bounds.width-45)/2, yPar: self.inputGoalView.circleImage.frame.origin.y){
                let tabBarVc = UIStoryboard(name: "MyTabBar", bundle: nil).instantiateViewController(withIdentifier: "MyTabBar") as! MyTabBarViewController
                self.navigationController?.pushViewController(tabBarVc, animated: true)
                self.userDataModel.initHabit(goalName: self.userGoalText, habitNum: 1)
                self.userDataModel.initSimilarHabit(currentHabitNum: 1)
                self.userDefaults.set(false, forKey: "firstLaunch")
                self.userDefaults.set(true, forKey: "firstTapped")
            }
        } else {
            sendAlert()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userGoalText = inputGoalView.goalTextField.text!
        textField.resignFirstResponder()
        if userGoalText.count > 25 {
            inputGoalView.wordCountOverAnimation()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userGoalText = inputGoalView.goalTextField.text!
        if userGoalText.count > 25 {
            inputGoalView.wordCountOverAnimation()
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
