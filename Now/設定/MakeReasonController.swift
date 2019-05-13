//
//  MakeReasonController.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/24.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit

class MakeReasonController: UIViewController {

    let makeReasonView = MakeReasonView.instance()
    override func viewDidLoad() {
        super.viewDidLoad()
        makeReasonView.frame = self.view.frame
        self.view.addSubview(makeReasonView)
        makeReasonView.dismissButton.addTarget(self, action: #selector(dismisButtonTapped), for: .touchUpInside)
        makeReasonView.setUpUi()
    }
    @objc func dismisButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
   
}
