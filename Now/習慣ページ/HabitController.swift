//
//  HabitControllerController.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/07.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit
import RealmSwift
import StoreKit


class HabitController: UIViewController {
    let habitView = HabitView.instance()
    let timeDataModel = TimeDataModel()
    let habitModel = HabitModel()
    let realm = try! Realm()
    var currentHabitNum = 0
    let userDefaults = UserDefaults.standard
    let quotationModel = QuotationModel()
    let tableSection = ["","","","","   おまけ"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        habitView.frame = self.view.frame
        self.view.addSubview(habitView)
        habitView.tableView.delegate = self
        habitView.tableView.dataSource = self
        habitView.tableView.register(UINib(nibName: "HabitNameTableViewCell", bundle: nil), forCellReuseIdentifier: "HabitNameTableViewCell")
        habitView.tableView.register(UINib(nibName: "HabitCircleTableViewCell", bundle: nil), forCellReuseIdentifier: "HabitCircleTableViewCell")
        habitView.tableView.register(UINib(nibName: "RemainLifeTableViewCell", bundle: nil), forCellReuseIdentifier: "RemainLifeTableViewCell")
        habitView.tableView.register(UINib(nibName: "EmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "EmptyTableViewCell")
        habitView.tableView.register(UINib(nibName: "PraiseTableViewCell", bundle: nil), forCellReuseIdentifier: "PraiseTableViewCell")
        habitView.tableView.tableFooterView = UIView(frame: .zero)
        
//        currentHabitNum = habitModel.currentHabitNum()
//        habitView.zeroValueOfCircleProgress(habitNum: currentHabitNum)
//        habitView.setUpParameter(habitNum: currentHabitNum)
        habitView.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Futura-Medium", size: 20)!,.foregroundColor: UIColor.black]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if userDefaults.object(forKey:"changePar") != nil {
            print("keyはあるよ")
            if userDefaults.bool(forKey: "changePar") == true {
                habitView.tableView.reloadData()
                userDefaults.set(false, forKey: "changePar")
            } else {
                print("keyあるけどリロードしなくて良い")
            }
        } else {
            print("ないよ")
        }
 
        currentHabitNum = habitModel.currentHabitNum()
//        habitView.zeroValueOfCircleProgress(habitNum: currentHabitNum)
//        habitView.setUpParameter(habitNum: currentHabitNum)
        let habit = realm.objects(HabitData.self).filter("habitNum == \(currentHabitNum)").first
        if habit?.notificationPage == false {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                let notificationVc = UIStoryboard(name: "InputNotification", bundle: nil).instantiateViewController(withIdentifier: "InputNotification") as! InputNotificationController
                notificationVc.modalPresentationStyle = .custom
                notificationVc.delegate = self
                notificationVc.transitioningDelegate = self
                self.present(notificationVc, animated: true, completion: nil)
            }
        }
//        //リセットの時間になっているか判定
//        timeDataModel.judgeResetTime(habitNum: currentHabitNum) {
//            self.habitView.judgeUi()
//        }
        //継続判定
        timeDataModel.judgeOfContinuous(habitNum: currentHabitNum)
        if #available(iOS 10.3, *) {
            if habit?.currentGoalNum == 5 {
                let similarHabit = realm.objects(SimilarHabitData.self).last
                if similarHabit?.modalReview == false {
                     SKStoreReviewController.requestReview()
                    try! realm.write {
                        similarHabit?.modalReview = true
                    }
                }
            }
        }
        //習慣を達成していた場合次の習慣の作成画面へ
        guard habit?.currentGoalNum == 30 else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let nextHabitVc = UIStoryboard(name: "NextHabit", bundle: nil).instantiateViewController(withIdentifier: "NextHabit") as! NextHabitController
            nextHabitVc.modalPresentationStyle = .overFullScreen
            nextHabitVc.modalTransitionStyle = .crossDissolve
            nextHabitVc.achievedHabit = false
            self.present(nextHabitVc, animated: true, completion: nil)
        }
        
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        habitView.currentValueOfCircleProgress(habitNum: currentHabitNum)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        habitView.zeroValueOfCircleProgress(habitNum: currentHabitNum)
    }
//    @objc func achieveButtonTapped() {
//        if userDefaults.bool(forKey: "firstTapped") {
//            userDefaults.set(false, forKey: "firstTapped")
//             self.userDefaults.synchronize()
//            //もしスタート日を登録していなかったら
//            let habit = realm.objects(HabitData.self).filter("habitNum == \(currentHabitNum)").first
//            if habit?.startDay == "" {
//                habitModel.saveFirstDay(habitNum: currentHabitNum)
//            } else {
//                print("習慣をスタートした日にちは登録されています")
//            }
//            //目標を達成しているかどうか
//            if habit?.currentGoalNum == 30 {
//                alreadyAchieveAlert()
//            } else {
//                //押した時間を登録
//                habitModel.registerHourOfButtonTapped(habitNum: currentHabitNum)
//                //リセットタイムを登録
//                habitModel.registerResetTime(habitNum: currentHabitNum)
//                habitView.increaseValue(habitNum: currentHabitNum)
//                self.habitView.judgeUi()
//                let modalViewController = UIStoryboard(name: "AchieveToday", bundle: nil).instantiateViewController(withIdentifier: "AchieveToday") as! AchieveTodayController
//                modalViewController.modalPresentationStyle = .custom
//                modalViewController.transitioningDelegate = self
//                modalViewController.delegate = self
//                present(modalViewController, animated: true, completion: nil)
//            }
//        } else {
//            sendAlert()
//        }
//    }
    
    //1日のボタンタップ上限を超えていた場合のアラート
    func sendAlert() {
        let alert: UIAlertController = UIAlertController(title: "本日の目標は達成しています", message: "本日の目標は達成していますが、取り消しますか？", preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "はい", style: UIAlertAction.Style.destructive) { (action: UIAlertAction!) in
            self.userDefaults.set(true, forKey: "firstTapped")
            self.habitView.decreaseValue(habitNum: self.currentHabitNum)
            self.dismiss(animated: true, completion: nil)
            self.habitView.tableView.reloadData()
//            self.habitView.currentValueOfCircleProgress(habitNum: self.currentHabitNum)
//            self.habitView.judgeUi()
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "いいえ", style: UIAlertAction.Style.cancel) { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //習慣を30日間達成していた場合のアラート
    func alreadyAchieveAlert() {
        let alert: UIAlertController = UIAlertController(title: "達成済みです", message: "この目標は達成済みです", preferredStyle: UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
}
extension HabitController: TellDismissFirstNoticeDelegate {
    func tellDismissFirstNotification() {
//         habitView.setUpParameter(habitNum: currentHabitNum)
         habitView.tableView.reloadData()
    }
}
extension HabitController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
extension HabitController: TellDismissDelegate {
    func tellDismiss() {
//        habitView.currentValueOfCircleProgress(habitNum: currentHabitNum)
        habitView.tableView.reloadData()
        
    }
}

extension HabitController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
         return tableSection.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableSection[section]
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label : UILabel = UILabel()
        label.backgroundColor = UIColor(hex: "F7F8FC")
        label.textColor = UIColor.darkGray
        if section == 4 {
            label.text = tableSection[section]
            label.font = UIFont.boldSystemFont(ofSize: 17)
        } else {
            label.text = tableSection[section]
        }
        return label
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 1
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 4 {
            return 55
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let habit = realm.objects(HabitData.self).filter("habitNum == \(currentHabitNum)").first
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell") as! EmptyTableViewCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
          
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HabitNameTableViewCell") as! HabitNameTableViewCell
             cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
             cell.selectionStyle = UITableViewCell.SelectionStyle.none
            //リセットの時間になっているか判定
            timeDataModel.judgeResetTime(habitNum: currentHabitNum) {
                let userDefaults = UserDefaults.standard
                if userDefaults.bool(forKey: "firstTapped") == true {
                    print("グレー")
                    cell.notAchieveLabel.isHidden = false
                    cell.userGoalLabel.textColor = UIColor(hex: "A9A9A9")
                } else {
                    print("ブラック")
                    cell.notAchieveLabel.isHidden = true
                    cell.userGoalLabel.textColor = UIColor(hex: "201E1F")
                }
            }
            cell.userGoalLabel.sizeToFit()
                    currentHabitNum = habitModel.currentHabitNum()
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.minimumLineHeight = ceil(cell.userGoalLabel.font.lineHeight) // 行の高さの最小値
                    paragraphStyle.maximumLineHeight = ceil(cell.userGoalLabel.font.lineHeight) // 行の高さの最大値
                    paragraphStyle.lineSpacing = ceil(cell.userGoalLabel.font.pointSize / 2) // 行と行の間隔
            
                    let attributes = [
                        NSAttributedString.Key.paragraphStyle: paragraphStyle,
                    ]
                    let attributedText = NSAttributedString(string: habit!.goalName, attributes: attributes as [NSAttributedString.Key : Any])
                    cell.userGoalLabel.attributedText = attributedText
                    cell.userGoalLabel.numberOfLines = 0 // 複数行の設定
                    cell.userGoalLabel.textAlignment = .center
//            cell.userGoalLabel.text = habit?.goalName
            cell.notRegisterTimeLabel.text = habitView.registerNoticeTime()
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HabitCircleTableViewCell") as! HabitCircleTableViewCell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            timeDataModel.judgeResetTime(habitNum: currentHabitNum) {
                let userDefaults = UserDefaults.standard
                if userDefaults.bool(forKey: "firstTapped") == true {
                    cell.currentGoalNum.textColor = UIColor(hex: "A9A9A9")
                } else {
                    cell.currentGoalNum.textColor = UIColor(hex: "201E1F")
                }
            }
            cell.currentGoalNum.text = "\( habit!.currentGoalNum)"
            cell.cirularProgressBar.maxValue =  CGFloat((habit?.dateToGoal)!)
            cell.cirularProgressBar.value =  0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                UIView.animate(withDuration: 1.0) {
                    cell.cirularProgressBar.maxValue = CGFloat((habit?.dateToGoal)!)
                    cell.cirularProgressBar.value = CGFloat((habit?.currentGoalNum)!)
                }
            }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PraiseTableViewCell") as! PraiseTableViewCell
            cell.praiseLabel.text = habitView.givePraise()
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
           
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: "RemainLifeTableViewCell") as! RemainLifeTableViewCell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            print("")
        case 1:
            print("")
        case 2:
                    if userDefaults.bool(forKey: "firstTapped") {
                        userDefaults.set(false, forKey: "firstTapped")
                         self.userDefaults.synchronize()
                        //もしスタート日を登録していなかったら
                        let habit = realm.objects(HabitData.self).filter("habitNum == \(currentHabitNum)").first
                        if habit?.startDay == "" {
                            habitModel.saveFirstDay(habitNum: currentHabitNum)
                        } else {
                            print("習慣をスタートした日にちは登録されています")
                        }
                        //目標を達成しているかどうか
                        if habit?.currentGoalNum == 30 {
                            alreadyAchieveAlert()
                        } else {
                            //押した時間を登録
                            habitModel.registerHourOfButtonTapped(habitNum: currentHabitNum)
                            //リセットタイムを登録
                            habitModel.registerResetTime(habitNum: currentHabitNum)
                            habitView.increaseValue(habitNum: currentHabitNum)
                            let modalViewController = UIStoryboard(name: "AchieveToday", bundle: nil).instantiateViewController(withIdentifier: "AchieveToday") as! AchieveTodayController
                            modalViewController.modalPresentationStyle = .custom
                            modalViewController.transitioningDelegate = self
                            modalViewController.delegate = self
                            present(modalViewController, animated: true, completion: nil)
                        }
                    } else {
                        sendAlert()
                }
        case 3:
            print("")
        default:
            let explainVc = UIStoryboard(name: "ExplainHabit", bundle: nil).instantiateViewController(withIdentifier: "ExplainHabit") as! ExplainHabitController
            self.present(explainVc, animated: true, completion: nil)
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 10
        case 1:
            return 151
        case 2:
            return 317
        case 3:
            return 130
        default:
            return 170
        }
    }
    
    
}

