//
//  PostDetailTitleCell.swift
//  kamimeguri
//
//  Created by Kentarou on 2018/07/23.
//  Copyright © 2018年 Chen Rui. All rights reserved.
//

import UIKit

class PostDetailTitleCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var logData: LogData? {
        didSet {
            if let logData = logData { //もしlogDateはnilじゃなかったら
                dateLabel.text = logData.dateString
                titleLabel.text = logData.postTempleName
                addressLabel.text = logData.postTempleAddress
            }
        }
    }
}
