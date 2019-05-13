//
//  InputView.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/07.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit

class InputView: UIView {
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var circleImage: UIImageView!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var wordCountOverLabel: UILabel!
    class func instance() -> InputView {
        return UINib(nibName: "InputView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! InputView
    }
    
    func firstUi() {
        circleImage.alpha = 0.0
        wordCountOverLabel.alpha = 0.0
        circleImage.isHidden = true
        nextButton.layer.cornerRadius = 25
        textFieldView.layer.cornerRadius = 25
        textFieldView.layer.borderColor = UIColor(hex: "E5E5E5").cgColor
        textFieldView.layer.borderWidth = 1
    }
    func cancelButtonNotDisplay() {
        cancelButton.alpha = 0.0
        cancelButton.isHidden = true
    }
    
    func animationStart(xPar:CGFloat, yPar: CGFloat, completion: @escaping () -> Void)  {
        UIView.animate(withDuration: 0.5, animations: {
            self.nextButton.frame = CGRect(x:xPar, y: yPar, width: 37, height: 37)
            self.nextButton.alpha = 0.0
        }){ _ in
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseIn], animations: {
                self.circleImage.alpha = 1.0
                self.circleImage.isHidden = false
            }) {_ in
                UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseIn], animations: {
                   completion()
                })
            }
        }
    }
    
    func wordCountOverAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseIn], animations: {
            self.wordCountOverLabel.alpha = 1.0
        }) {_ in
            UIView.animate(withDuration: 5.0, delay: 0.0, options: [.curveEaseIn], animations: {
                self.wordCountOverLabel.alpha = 0.0
            })
        }
    }
    
}
