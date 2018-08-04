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

class LogData { //データを受け入れるお皿です,どんな値を入れるか、渡すか細かく設定する
    let realm = try! Realm()
    
    var id: Int?
    var scencePhoto: UIImage?
    var syuinPhoto: UIImage?
    var kujiPhoto: UIImage?
    
    var postYear: String = ""
    var postDate: String = ""
    var postWeekly: String = ""
    
    var postedText: String = ""
    var postTempleName: String = ""
    var postTempleAddress: String = ""
    
    var images: [UIImage?] {
        return [scencePhoto, syuinPhoto, kujiPhoto]
    }
    
    var dateString: String {
        return postYear + postDate
    }
    
    init(diary:Diary) {//なんでここでinit?
        id = diary.id //optional型はif let を使う
        //path -> data
//        if let scencePhoto = diary.scencePhoto{
//            self.scencePhoto = UIImage(data: scencePhoto)
//        }
//        if let syuinPhotoPath = diary.syuinPhoto{
//        self.syuinPhoto = UIImage(data:syuinPhoto)
//        }
//        if let kujiPhoto = diary.kujiPhoto{
//            self.kujiPhoto = UIImage(data:kujiPhoto)
//        }
//
        let PostYearInfo = DateFormatter()
        PostYearInfo.setTemplate(.Year)
        postYear = "\(PostYearInfo.string(from: diary.dateInfo))"
        
        let PostMDInfo = DateFormatter()
        PostMDInfo.setTemplate(.MDDate)
        postDate = "\(PostMDInfo.string(from: diary.dateInfo))"
        
        let PostweekDayInfo = DateFormatter()
        PostweekDayInfo.setTemplate(.weekDay)
        postWeekly = "\(PostweekDayInfo.string(from: diary.dateInfo))"
        
        if let diarytext = diary.DiaryText{
            self.postedText = diarytext
        }
        postTempleName = diary.postTempleName
        postTempleAddress = diary.postTempleAddress
    
}

}
