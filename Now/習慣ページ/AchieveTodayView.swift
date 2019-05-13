//
//  AchieveTodayView.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/07.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit

class AchieveTodayView: UIView {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var quotationLabel: UILabel!
    @IBOutlet weak var greatManLabel: UILabel!
    @IBOutlet weak var niceLabel: UILabel!
    @IBOutlet weak var todayQuotationLabel: UILabel!
  
    let quotationModel = QuotationModel()
    class func instance() -> AchieveTodayView {
        return UINib(nibName: "AchieveTodayView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! AchieveTodayView
    }
    func setUpUi() {
        niceLabel.alpha = 0.0
        backButton.alpha = 0.0
        quotationLabel.alpha = 0.0
        greatManLabel.alpha = 0.0
        todayQuotationLabel.alpha = 0.0
        backButton.layer.cornerRadius = 20
    }
    
    func setUpQuotation() {
        let iValue = Int.random(in: 0 ... 58)
//        quotationLabel.text = quotationModel.quotationArray[iValue]
        greatManLabel.text =  quotationModel.greatManArray[iValue]
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = ceil(quotationLabel.font.lineHeight) // 行の高さの最小値
        paragraphStyle.maximumLineHeight = ceil(quotationLabel.font.lineHeight) // 行の高さの最大値
        paragraphStyle.lineSpacing = ceil(quotationLabel.font.pointSize / 2) // 行と行の間隔
        
        let attributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            ]
        let attributedText = NSAttributedString(string: quotationModel.quotationArray[iValue], attributes: attributes as [NSAttributedString.Key : Any])
        quotationLabel.attributedText = attributedText
        
        quotationLabel.numberOfLines = 0 // 複数行の設定
        quotationLabel.lineBreakMode = NSLineBreakMode.byWordWrapping // 複数行のとき、単語単位で折り返す
        quotationLabel.sizeToFit() // 最適なサ
      
    }
    func animationStart()  {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseIn], animations: {
            self.niceLabel.alpha = 1.0
//                 self.niceLabel.frame = CGRect(x: 27, y: 98, width: 136, height: 44)
            }) {_ in
                UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseIn], animations: {
                    self.todayQuotationLabel.alpha = 1.0
                    self.quotationLabel.alpha = 1.0
                    self.greatManLabel.alpha = 1.0
                    self.backButton.alpha = 1.0
                })
        }
    }

}
