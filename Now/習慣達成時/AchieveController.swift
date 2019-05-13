//
//  AchieveController.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/08.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit
protocol TellGoalPageDelegate: class {
    func tellDismiss()
}
class AchieveController: UIViewController {
    let achieveView = AchieveView.instance()
    weak var delegate: TellGoalPageDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        achieveView.frame = self.view.frame
        self.view.addSubview(achieveView)
        achieveView.dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        achieveView.setUpUi()
    }
    @objc func dismissButtonTapped() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        delegate?.tellDismiss()
    }

   

}
