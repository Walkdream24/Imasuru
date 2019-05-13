//
//  MakeReasonView.swift
//  Now
//
//  Created by 中重歩夢 on 2019/03/24.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit

class MakeReasonView: UIView {
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    class func instance() -> MakeReasonView {
        return UINib(nibName: "MakeReasonView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! MakeReasonView
    }
    func setUpUi() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = ceil(contentLabel.font.lineHeight) // 行の高さの最小値
        paragraphStyle.maximumLineHeight = ceil(contentLabel.font.lineHeight) // 行の高さの最大値
        paragraphStyle.lineSpacing = ceil(contentLabel.font.pointSize / 1.5) // 行と行の間隔
        
        let attributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            ]
        let attributedText = NSAttributedString(string:"「継続して何かをする」ということを手助けしたいという思いから作りました。習慣が人を作るという言葉があるように、習慣化の力には無限の可能性があると思います。\nイチロー選手の\n「特別なことをするために、特別なことをするのではない。特別なことをするために、普段どおりの当たり前のことをする。」\n\nという言葉があります。偉大な成功を収めた人も毎日の小さな積み重ねから成り立っているのだと感じます。一緒に小さなことから何か始めてみましょう！", attributes: attributes as [NSAttributedString.Key : Any])
        contentLabel.attributedText = attributedText
        
        contentLabel.numberOfLines = 0 // 複数行の設定
        contentLabel.lineBreakMode = NSLineBreakMode.byWordWrapping // 複数行のとき、単語単位で折り返す
        contentLabel.sizeToFit() // 最適なサ
    }
    
}
