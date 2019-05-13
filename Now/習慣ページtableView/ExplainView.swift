//
//  ExplainView.swift
//  Now
//
//  Created by 中重歩夢 on 2019/04/05.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit

class ExplainView: UIView {
    @IBOutlet weak var tableView: UITableView!
    class func instance() -> ExplainView {
        return UINib(nibName: "ExplainView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! ExplainView
    }

}
