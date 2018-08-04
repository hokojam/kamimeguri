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
        id = diary.id
        //path -> data
        //風景写真
        if let scencePhotoPath = diary.scencePhotoPath{
            self.scencePhoto = UIImage(contentsOfFile: scencePhotoPath)
            //let logScenceImage = FileManager.default.getImage(atPath: scencePhotoPath)
            //self.scencePhoto = logScenceImage
        }
        //御朱印写真
        if let syuinPhotoPath = diary.syuinPhotoPath{
            self.syuinPhoto = UIImage(contentsOfFile: syuinPhotoPath)
            //let logSyuinImage = FileManager.default.getImage(atPath: syuinPhotoPath)
            //self.syuinPhoto = logSyuinImage
        }
        //くじ写真
        if let kujiPhotoPath = diary.syuinPhotoPath{
            self.kujiPhoto = UIImage(contentsOfFile: kujiPhotoPath)
            //let logKujiImage = FileManager.default.getImage(atPath: kujiPhotoPath)
            //self.kujiPhoto = logKujiImage
        }
        
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
