//
//  Diary.swift
//  kamimeguri
//
//  Created by Chen Rui on 2018/07/06.
//Copyright © 2018 Chen Rui. All rights reserved.

import Foundation
import RealmSwift

class Diary: Object{
    @objc dynamic var date : String = ""
    @objc dynamic var dateInfo = Date()
    @objc dynamic var DiaryText : String? = ""
    @objc dynamic var omairiIcon : Data? = nil
    @objc dynamic var scencePhoto : Data? = nil
    @objc dynamic var kujiPhoto : Data? = nil
    @objc dynamic var syuinPhoto : Data? = nil
    override static func primaryKey() -> String? {
        return "date"
        
    }
    
}
