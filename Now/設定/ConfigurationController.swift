//
//  ConfigurationController.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/07.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit

class ConfigurationController: UIViewController {
    let configurationView = ConfigurationView.instance()
    let tableSection = ["",""]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationView.frame = self.view.frame
        self.view.addSubview(configurationView)
        configurationView.tableView.delegate = self
        configurationView.tableView.dataSource = self
        configurationView.tableView.register(UINib(nibName: "ConfigurationTableViewCell", bundle: nil), forCellReuseIdentifier: "ConfigurationTableViewCell")
        configurationView.tableView.register(UINib(nibName: "EmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "EmptyTableViewCell")
        configurationView.tableView.tableFooterView = UIView(frame: .zero)
         configurationView.tableView.register(UINib(nibName: "CreateNewHabitTableViewCell", bundle: nil), forCellReuseIdentifier: "CreateNewHabitTableViewCell")
    }
    //習慣消去
    func deleteHabitAlert() {
        let alert: UIAlertController = UIAlertController(title: "確認", message: "現在の習慣が消去されます。本当に続行しますか？\n”二兎を追う者は一兎をも得ず”ですよね…", preferredStyle: UIAlertController.Style.actionSheet)
        let defaultAction: UIAlertAction = UIAlertAction(title: "削除", style: UIAlertAction.Style.destructive) { (action: UIAlertAction!) in
            
            let nextHabitVc = UIStoryboard(name: "NextHabit", bundle: nil).instantiateViewController(withIdentifier: "NextHabit") as! NextHabitController
            nextHabitVc.achievedHabit = false
            self.present(nextHabitVc, animated: true, completion: nil)
//            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "いいえ", style: UIAlertAction.Style.cancel) { (action: UIAlertAction!) in
            
        }
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = self.view
        let screenSize = UIScreen.main.bounds
        // ここで表示位置を調整
        // xは画面中央、yは画面下部になる様に指定
        alert.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width/2, y: screenSize.size.height, width: 0, height: 0)
        self.present(alert, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configurationView.tableView.reloadData()
    }
}

extension ConfigurationController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableSection.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell") as! EmptyTableViewCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: "ConfigurationTableViewCell") as! ConfigurationTableViewCell
            switch indexPath.row {
            case 0:
                cell.configLabel.text = "アプリを評価する"
                cell.configContentLabel.text = ""
                return cell
            case 1:
                cell.configLabel.text = "アプリを作った理由"
                cell.configContentLabel.text = ""
                return cell
            case 2:
                cell.configLabel.text = "通知時間"
                cell.configContentLabel.text = configurationView.registerNoticeTime()
                return cell
            default :
                let cell = tableView.dequeueReusableCell(withIdentifier: "CreateNewHabitTableViewCell") as! CreateNewHabitTableViewCell
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            print("")
        default:
            switch indexPath.row {
            case 0:
                if let url = URL(string: "itms-apps://itunes.apple.com/app/id1456245094?action=write-review") {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:])
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            case 1:
                let reasonVc = UIStoryboard(name: "MakeReason", bundle: nil).instantiateViewController(withIdentifier: "MakeReason") as! MakeReasonController
                self.present(reasonVc, animated: true, completion: nil)
            case 2:
                let noticeVc = UIStoryboard(name: "InputNotification", bundle: nil).instantiateViewController(withIdentifier: "InputNotification") as! InputNotificationController
                noticeVc.configPage = true
                self.present(noticeVc, animated: true, completion: nil)
            default :
                deleteHabitAlert()
            }
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
           return 10
        default :
            return 61
        }
    }
}
