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
    
    init(){//なんでここでinit?
    //let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    scencePhotoName = "/Scence.png"
    scencePhotoPath = FileManager.default.documentPath(fileName: scencePhotoName)
    scencePhotoURL  = URL(string: scencePhotoPath)
    scencePhotoData = try? Data(contentsOf: scencePhotoURL!)
    
    syuinPhotoName = "/Syuin.png"
    syuinPhotoPath = FileManager.default.documentPath(fileName: syuinPhotoName)
    syuinPhotoURL  = URL(string: syuinPhotoPath)
    syuinPhotoData = try? Data(contentsOf: syuinPhotoURL!)
    
    kujiPhotoName = "/Syuin.png"
    kujiPhotoPath = FileManager.default.documentPath(fileName: syuinPhotoName)
    kujiPhotoURL  = URL(string: syuinPhotoPath)
    kujiPhotoData = try? Data(contentsOf: syuinPhotoURL!)

}

}
