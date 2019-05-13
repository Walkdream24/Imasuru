//
//  ExplainTableViewCell.swift
//  Now
//
//  Created by 中重歩夢 on 2019/04/05.
//  Copyright © 2019 Ayumu Nakashige. All rights reserved.
//

import UIKit
protocol BackButtonTappedDelegate: class {
    func dismissButtonTapped()
}
class ExplainTableViewCell: UITableViewCell {
    weak var delegate: BackButtonTappedDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func dismissTapped(_ sender: Any) {
        delegate?.dismissButtonTapped()
    }
    
}
