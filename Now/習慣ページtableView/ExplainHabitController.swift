//
//  ExplainHabitController.swift
//  Now
//
//  Created by 中重歩夢 on 2019/04/05.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit

class ExplainHabitController: UIViewController {
    let explainView = ExplainView.instance()
    let tableSection = ["", ""]

    override func viewDidLoad() {
        super.viewDidLoad()
        explainView.frame = self.view.frame
        self.view.addSubview(explainView)
        explainView.tableView.delegate = self
        explainView.tableView.dataSource = self
        explainView.tableView.tableFooterView = UIView(frame: .zero)
        explainView.tableView.register(UINib(nibName: "ExplainTableViewCell", bundle: nil), forCellReuseIdentifier: "ExplainTableViewCell")


    }
}
extension ExplainHabitController: BackButtonTappedDelegate {
    func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
extension ExplainHabitController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return tableSection.count
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExplainTableViewCell") as! ExplainTableViewCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 965
    }
    
    
}
