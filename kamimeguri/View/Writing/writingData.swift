//
//  writingData.swift
//  kamimeguri
//
//  Created by Chen Rui on 2018/08/06.
//  Copyright © 2018 Chen Rui. All rights reserved.
//

import Foundation
class WritingData{
    let scencePhotoName :String!
    var scencePhotoPath :String!
    var scencePhotoURL : URL?
    var scencePhotoData : Data?
    
    let syuinPhotoName :String!
    var syuinPhotoPath :String!
    var syuinPhotoURL : URL?
    var syuinPhotoData : Data?
    
    let kujiPhotoName :String!
    var kujiPhotoPath :String!
    var kujiPhotoURL : URL?
    var kujiPhotoData : Data?
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func initPath(id:Int)->String{
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/\(id)"
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
        scencePhotoName = "/Scence.png"
        syuinPhotoName = "/Syuin.png"
        kujiPhotoName = "/Kuji.png"
    }
    
    func getImagePath(path:String!,photoname:String!) ->String{
        guard let path = path,let photoname = photoname else {return ""}
        let imagePath = "\(path)\(photoname)"
        return imagePath
    }
    
    func getImageURL(photoname:String) ->URL{
        let photoURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(photoname)")
        return photoURL
    }//tmpだからだめ
    
    func saveImage(path:String,imagedata:Data){
        FileManager.default.createFile(atPath:path, contents: imagedata, attributes: nil)
    }
}
