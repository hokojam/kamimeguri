//
//  WishListCell.swift
//  kamimeguri
//
//  Created by Chen Rui on 2018/07/16.
//  Copyright © 2018 Chen Rui. All rights reserved.
//

import UIKit

class WishListCell: UICollectionViewCell {
    
    @IBOutlet weak var WishItem: UIButton!
    
//    WishItem.setImage(WishImgOff, for: .normal)
//    WishItem.setImage(WishImgOn, for: .highlighted)
//
    
    let BtnList = [UIButton]()
    
    
    //for WishItem in Wish
    
    @IBAction func WishItemBeTapped(_ sender: UIButton) {
      sender.isSelected = !sender.isSelected
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}

