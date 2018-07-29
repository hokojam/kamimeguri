//
//  TabBarController.swift
//  kamimeguri
//
//  Created by Chen Rui on 2018/07/02.
//  Copyright © 2018 Chen Rui. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    @objc func handleTouchTabbarCenter(sender : UIButton)
    {
        if let count = self.tabBar.items?.count
        {
            let i = floor(Double(count / 2))
            self.selectedViewController = self.viewControllers?[Int(i)]
        }
    }
    
    func addCenterButton(withImage buttonImage : UIImage, highlightImage: UIImage) {
        
        let paddingBottom : CGFloat = 4
        
        let mButtonBg = UIButton(type: .custom)
        mButtonBg .autoresizingMask = [.flexibleRightMargin, .flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin]
        mButtonBg.frame.size = CGSize(width: 88, height: 88)
        mButtonBg .backgroundColor = UIColor(hex: "ffffff")
        //button.frame = CGRect(x: 0.0, y: 0.0, width: buttonImage.size.width / 2.0, height: buttonImage.size.height / 2.0)
        //button.setBackgroundImage(buttonImage, for: .normal)
        //button.setBackgroundImage(highlightImage, for: .highlighted)
        //button.backgroundColor = .white
       
//      if mButtonBg .isSelected == true{
//         mButtonBg .backgroundColor = UIColor(hex: "FF00FF")
// }
        mButtonBg .layer.cornerRadius = 44 //丸角: .layer.cornerRadius
        mButtonBg .layer.masksToBounds = true
        mButtonBg .center = CGPoint(x: UIScreen.main.bounds.width / 2, y:UIScreen.main.bounds.height - 45)
        
        
        let rectBoundTabbar = self.tabBar.bounds
        let xx = rectBoundTabbar.midX
        let yy = rectBoundTabbar.midY - paddingBottom
        mButtonBg .center = CGPoint(x: xx, y: yy)
   
        self.tabBar.addSubview(mButtonBg )
        self.tabBar.sendSubview(toBack: mButtonBg )//.bringSubView(toFront(String: "subview name"))
        
        mButtonBg .addTarget(self, action: #selector(handleTouchTabbarCenter), for: .touchUpInside)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 起動時表示するタブを中央にする
        selectedIndex = 1
        
        if let newButtonImage = UIImage(named: "location") {
            self.addCenterButton(withImage: newButtonImage, highlightImage: newButtonImage)
        }
    }
}
