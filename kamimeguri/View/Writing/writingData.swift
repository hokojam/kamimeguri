//
//  writingData.swift
//  kamimeguri
//
//  Created by Chen Rui on 2018/08/06.
//  Copyright © 2018 Chen Rui. All rights reserved.
//

import Foundation
class WritingData{
    var scencePhotoName :String!
    var scencePhotoPath :String!
    var scencePhotoURL : URL?
    var scencePhotoData : Data?
    
    var syuinPhotoName :String!
    var syuinPhotoPath :String!
    var syuinPhotoURL : URL?
    var syuinPhotoData : Data?
    
   var kujiPhotoName :String!
   var kujiPhotoPath :String!
   var kujiPhotoURL : URL?
   var kujiPhotoData : Data?
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func initPath()->String{
        //画像保存パスを設定
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first! + "/UserPhoto"
        //=> /var/mobile/Containers/Data/Application/XXXXX-XXXX-XXXX-XXXXXX/Library/Caches/UserPhoto
        do {
        // ディレクトリが存在するかどうかの判定
        if !FileManager.default.fileExists(atPath: path) {
        // ディレクトリが無い場合ディレクトリを作成する
        try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: false , attributes: nil)
        }
        
        } catch {
        // エラー処理
        }
        return path
    }
    
 

    
    init(){//なんでここでinit?
    //let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    //scencePhotoName = "/Scence.png"
    scencePhotoPath = "\(String(describing: path)) + \(scencePhotoName)"
        //FileManager.default.documentPath(fileName: scencePhotoName)
    scencePhotoURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(scencePhotoName)")
    //scencePhotoData = try? Data(contentsOf: scencePhotoURL!)
        
    //syuinPhotoName = "/Syuin.png"
    syuinPhotoPath = "\(String(describing: path)) + \(syuinPhotoName)"
    syuinPhotoURL  = URL(string: syuinPhotoPath)
    //syuinPhotoData = try? Data(contentsOf: syuinPhotoURL!)
        
    
    //kujiPhotoName = "/Kuji.png"
    kujiPhotoPath = "\(String(describing: path)) + \(kujiPhotoName)"
    kujiPhotoURL  = URL(string: syuinPhotoPath)
    //kujiPhotoData = try? Data(contentsOf: syuinPhotoURL!)
    }
    
    func getscencePhotoName(id:Int) -> String{
        scencePhotoName = "\(id)" + "/Scence.png"
        return scencePhotoName
    }
    
    func getsyuinPhotoName(id:Int)  -> String{
        syuinPhotoName = "/Syuin.png"
        return syuinPhotoName
    }
    
    func getkujiPhotoName(id:Int) -> String{
        kujiPhotoName = "/Syuin.png"
        return kujiPhotoName
    }
    
    func getImagePath(photoname:String) ->String{
        let imagePath = "\(String(describing: path)) + \(kujiPhotoName)"
        return imagePath
    }
    
    func getImageURL(photoname:String) ->URL{
        let photoURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(photoname)")
        return photoURL
    }
    func saveImage(data:Data, photoURL:URL) -> Void {
        try? data.write(to: photoURL)
    }

}
