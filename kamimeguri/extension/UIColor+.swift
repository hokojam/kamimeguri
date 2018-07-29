//
//  ColorHex.swift
//  kamimeguri
//
//  Created by Chen Rui on 2018/06/26.
//  Copyright © 2018 Chen Rui. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat) {
        
        let v = hex.map { String($0) } + Array(repeating: "0", count: max(6 - hex.count, 0))
        let r = CGFloat(Int(v[0] + v[1], radix: 16) ?? 0) / 255.0
        let g = CGFloat(Int(v[2] + v[3], radix: 16) ?? 0) / 255.0
        let b = CGFloat(Int(v[4] + v[5], radix: 16) ?? 0) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1.0)
    }
    
    class func skyBlue() -> UIColor {
        return #colorLiteral(red: 0, green: 0.8047479987, blue: 0.8315293789, alpha: 1)
    }
    
    class func Orange() -> UIColor {
        return #colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1)
    }
    
    class func GrassGreen() -> UIColor {
        return #colorLiteral(red: 0.5921568627, green: 0.7058823529, blue: 0.07843137255, alpha: 1)
        
    }
}

//使い方:
//hogeView.backgroundColor = UIColor(hex: "FF00FF", alpha: 0.7)
//hogeView.backgroundColor = UIColor(hex: "FF00FF")
