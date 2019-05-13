//
//  InputNotificationView.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/11.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit

class InputNotificationView: UIView {
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var alarmTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var checkCirlce: UIImageView!
    @IBOutlet weak var laterButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var notNoticeButton: UIButton!
    var toolBar:UIToolbar!
    
    class func instance() -> InputNotificationView {
        return UINib(nibName: "InputNotificationView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! InputNotificationView
    }
    func setUpUi() {
        nextButton.layer.cornerRadius = 25
        textFieldView.layer.cornerRadius = 25
        textFieldView.layer.borderColor = UIColor(hex: "E5E5E5").cgColor
        textFieldView.layer.borderWidth = 1
        checkCirlce.alpha = 0.0
    }
    func notdisplayCancelButton() {
        cancelButton.alpha = 0.0
        cancelButton.isHidden = true
    }
    func notDisplayLaterButton() {
        laterButton.alpha = 0.0
        laterButton.isHidden = true
    }
    func animationStart(xPar:CGFloat, yPar: CGFloat,completion: @escaping () -> Void)  {
        UIView.animate(withDuration: 0.5, animations: {
            self.nextButton.frame = CGRect(x: xPar, y: yPar, width: 45, height: 45)
            self.nextButton.alpha = 0.0
        }){ _ in
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseIn], animations: {
                self.checkCirlce.alpha = 1.0
                self.checkCirlce.isHidden = false
                self.vibrated(vibrated: true, view: self.checkCirlce)
                
            }) {_ in
                UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseIn], animations: {
                    completion()
                })
            }
        }
    }
    func degreesToRadians(degrees: Float) -> Float {
        return degrees * Float(Double.pi) / 180.0
    }
    
    func vibrated(vibrated:Bool, view: UIView) {
        if vibrated {
            var animation: CABasicAnimation
            animation = CABasicAnimation(keyPath: "transform.rotation")
            animation.duration = 0.15
            animation.fromValue = degreesToRadians(degrees: 3.0)
            animation.toValue = degreesToRadians(degrees: -3.0)
            animation.repeatCount = Float.infinity
            animation.autoreverses = true
            view.layer .add(animation, forKey: "VibrateAnimationKey")
        }
        else {
            view.layer.removeAnimation(forKey: "VibrateAnimationKey")
        }
    }
    
    func alarmAnimation() {
        
    }
    
}
