//
//  Bundle+.swift
//  kamimeguri
//
//  Created by Kentarou on 2018/07/24.
//  Copyright © 2018年 Chen Rui. All rights reserved.
//

import Foundation

extension Bundle {
    
    class func plistString(key: PlistKeys) -> String {
        return Bundle.main.infoDictionary?[key.rawValue] as? String ?? ""
    }
}

enum PlistKeys: String {
    
    case googleMapKey = "GoogleMapKey"
}
