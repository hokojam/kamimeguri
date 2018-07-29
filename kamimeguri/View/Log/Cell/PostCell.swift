//
//  PostCell.swift
//  kamimeguri
//
//  Created by Chen Rui on 2018/07/22.
//  Copyright © 2018 Chen Rui. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet private weak var postCellBg: UIView!
    @IBOutlet private weak var dateRoll: UIImageView!
    @IBOutlet private weak var postYearLabel: UILabel!
    @IBOutlet private weak var postDateLabel: UILabel!
    @IBOutlet private weak var postWeekdayLabel: UILabel!
    @IBOutlet private weak var postTempleName: UILabel!
    @IBOutlet private weak var postTempleAdd: UILabel!
    @IBOutlet private weak var imageList: UIStackView!
    
    @IBOutlet private var postImages: [UIImageView]!
    
    var logData: LogData? {
        didSet {
            if let logData = logData {
                for item in postImages.enumerated() {
                    item.element.image = logData.images[item.offset]
                }
                postYearLabel.text = logData.postYear
                postDateLabel.text = logData.postDate
                postWeekdayLabel.text = logData.postWeekly
                
                postTempleName.text = logData.postTempleName
                postTempleAdd.text = logData.postTempleAddress
            }
        }
    }
}
