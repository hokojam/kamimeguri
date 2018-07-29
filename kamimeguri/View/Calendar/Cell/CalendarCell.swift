//
//  CalendarCell.swift
//  Calendar
//
//  Created by Kentarou on 2018/05/03.
//  Copyright © 2018年 Kentarou. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var selectedDateImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
