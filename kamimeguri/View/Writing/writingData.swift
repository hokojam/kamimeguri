//
//  writingData.swift
//  kamimeguri
//
//  Created by Chen Rui on 2018/08/06.
//  Copyright © 2018 Chen Rui. All rights reserved.
//

import Foundation
class WiringData{
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
    
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    private func saveImage(data:Data, id:Int) -> String {
        let imageName = "\(id)" + ".jpeg"
        let filename = getDocumentsDirectory().appendingPathComponent(imageName)
        try? data.write(to: filename)
        return imageName
    }
    
    init(id:Int){//なんでここでinit?
    //let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    scencePhotoName = "/" + "\(id)" + "/Scence.png"
    scencePhotoPath = FileManager.default.documentPath(fileName: scencePhotoName)
    scencePhotoURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(scencePhotoName)")
        //
        
    //scencePhotoURL  = URL(string: scencePhotoPath)
    scencePhotoData = try? Data(contentsOf: scencePhotoURL!)
    
    syuinPhotoName =  "/" + "\(id)" + "/Syuin.png"
    syuinPhotoPath = FileManager.default.documentPath(fileName: syuinPhotoName)
    syuinPhotoURL  = URL(string: syuinPhotoPath)
    syuinPhotoData = try? Data(contentsOf: syuinPhotoURL!)
    
    kujiPhotoName = "/" + "\(id)" + "/Syuin.png"
    kujiPhotoPath = FileManager.default.documentPath(fileName: syuinPhotoName)
    kujiPhotoURL  = URL(string: syuinPhotoPath)
    kujiPhotoData = try? Data(contentsOf: syuinPhotoURL!)

//        private func saveImage(data:Data, id:Int) -> String {
//            let imageName = "\(id)" + ".jpeg"
//            let filename = getDocumentsDirectory().appendingPathComponent(imageName)
//            try? data.write(to: filename)
//            return imageName
//        }
}

}
