//
//  Diary.swift
//  kamimeguri
//
//  Created by Chen Rui on 2018/07/06.
//Copyright © 2018 Chen Rui. All rights reserved.

import Foundation
import RealmSwift

class Diary: Object{
    //let logData = List<LogData>()
    @objc dynamic var id: Int = 1
    @objc dynamic var postTempleName : String = ""
    @objc dynamic var postTempleAddress : String = ""
    @objc dynamic var date : String = ""
    @objc dynamic var dateInfo = Date()
    @objc dynamic var DiaryText : String? = ""
    @objc dynamic var omairiIcon : String? = nil
    @objc dynamic var scencePhotoPath : String? = nil
    @objc dynamic var kujiPhotoPath : String? = nil
    @objc dynamic var syuinPhotoPath : String? = nil
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func getLastId() -> Int {
        let realm = try! Realm()
        if let diary = realm.objects(Diary.self).last { //Diary is a type not object. so add self
            return diary.id + 1
        } else {
            return 1
        }
    }
}
