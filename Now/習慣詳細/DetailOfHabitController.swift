//
//  DetailOfHabitController.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/07.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit
import RealmSwift

class DetailOfHabitController: UIViewController {
    let tableSection = ["","","   これまでの習慣"]
    var habitList: [HabitData] = []
    let detailOfHabitView = DetailOfHabitView.instance()
    let detailOfHabitModel = DetailOfHabitModel()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        detailOfHabitView.frame = self.view.frame
        self.view.addSubview(detailOfHabitView)
        detailOfHabitView.tableView.delegate = self
        detailOfHabitView.tableView.dataSource = self
        detailOfHabitView.tableView.register(UINib(nibName: "EmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "EmptyTableViewCell")
        detailOfHabitView.tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
        detailOfHabitView.tableView.register(UINib(nibName: "HabitListTableViewCell", bundle: nil), forCellReuseIdentifier: "HabitListTableViewCell")
        detailOfHabitView.tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let realm = try! Realm()
        let habits = realm.objects(HabitData.self)
        habitList = []
        habits.forEach { (habit) in
            habitList.append(habit)
        }
        detailOfHabitView.tableView.reloadData()

    }

}
extension DetailOfHabitController: UITableViewDelegate, UITableViewDataSource {
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
        if section == 0 {
            label.text = tableSection[section]
        } else if section == 1 {
            label.text = tableSection[section]
        } else {
            label.text = tableSection[section]
            label.font = UIFont.boldSystemFont(ofSize: 17)
        }
        return label
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else if section == 1 {
            return 0
        } else {
            return 55
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 2
        } else {
            return habitList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell") as! EmptyTableViewCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell") as! DetailTableViewCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            switch indexPath.row {
            case 0:
                cell.dateLabel.text = "\(detailOfHabitModel.allHabitDays())"
                return cell
            default:
                cell.titleOfItemLabel.text = "現在の目標の連続達成日数"
                cell.dateLabel.text = "\(detailOfHabitModel.continuousOfHabit())"
                return cell
            }
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HabitListTableViewCell") as! HabitListTableViewCell
            cell.goalLabel.text = habitList[indexPath.row].goalName
            cell.progressLabel.text = "\(habitList[indexPath.row].currentGoalNum)"
            cell.circularProgress.maxValue = CGFloat(habitList[indexPath.row].dateToGoal)
            cell.circularProgress.value = CGFloat(habitList[indexPath.row].currentGoalNum)
            if habitList[indexPath.row].currentGoalNum != 30 {
                if habitList[indexPath.row].currentGoalNum == 0 {
                    detailOfHabitModel.nothingStartDay(habitNum: habitList[indexPath.row].habitNum)
                    cell.goalStatusLabel.text = "さっそく始めよう！"
                    cell.periodLabel.text = "まだ始めていません"
                } else {
                    let realm = try! Realm()
                    let similarHabit = realm.objects(SimilarHabitData.self).last
                    if habitList[indexPath.row].habitNum != similarHabit?.currentHabitNum {
                        cell.goalStatusLabel.text = "終了"
                        cell.periodLabel.text = "\(habitList[indexPath.row].startDay)から"
                    } else {
                        cell.goalStatusLabel.text = "挑戦中"
                        cell.periodLabel.text = "\(habitList[indexPath.row].startDay)から"
                    }
                }
            } else {
                cell.goalStatusLabel.text = "達成"
                cell.periodLabel.text = "\(habitList[indexPath.row].startDay)から\(habitList[indexPath.row].finishDay)まで"
            }
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        switch indexPath.section {
        case 0:
            let configuration = UISwipeActionsConfiguration(actions: [])
            return configuration
        case 1:
            let configuration = UISwipeActionsConfiguration(actions: [])
            return configuration
        default:
            let destructiveAction = UIContextualAction(style: .destructive, title: "削除") { (action, view, completionHandler) in
                let alert: UIAlertController = UIAlertController(title: "記録が削除されてしまいます", message: "本当にこの記録を削除してもよろしいですか？", preferredStyle: UIAlertController.Style.alert)
                let defaultAction: UIAlertAction = UIAlertAction(title: "はい", style: UIAlertAction.Style.destructive) { (action: UIAlertAction!) in
                    let realm = try! Realm()
                    try! realm.write {
                        realm.delete(self.habitList[indexPath.row])
                    }
                }
                let cancelAction: UIAlertAction = UIAlertAction(title: "いいえ", style: UIAlertAction.Style.cancel) { (action: UIAlertAction!) in
                    self.dismiss(animated: true, completion: nil)
                }
                alert.addAction(defaultAction)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
                
                completionHandler(true)
            }
            let configuration = UISwipeActionsConfiguration(actions: [destructiveAction])
            configuration.performsFirstActionWithFullSwipe = false
            return configuration
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 10
        case 1:
            return 135
           
        default:
            return 149
            
        }
    }
    
}
