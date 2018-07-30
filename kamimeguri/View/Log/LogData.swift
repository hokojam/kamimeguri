//
//  LogData.swift
//  kamimeguri
//
//  Created by Kentarou on 2018/07/23.
//  Copyright © 2018年 Chen Rui. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class LogData {
    let realm = try! Realm()
    
    var id: Int?
    var photo1: UIImage?
    var photo2: UIImage?
    var photo3: UIImage?
    
    var postYear: String = ""
    var postDate: String = ""
    var postWeekly: String = ""
    
    var postedText: String = ""
    var postTempleName: String = ""
    var postTempleAddress: String = ""
    
    var images: [UIImage?] {
        return [photo1, photo2, photo3]
    }
    
    var dateString: String {
        return postYear + postDate
    }
    
}
