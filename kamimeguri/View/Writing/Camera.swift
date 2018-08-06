//
//  File.swift
//  kamimeguri
//
//  Created by Chen Rui on 2018/07/05.
//  Copyright © 2018 Chen Rui. All rights reserved.
//

import Foundation
import UIKit

//写真撮影ボタンのクラス
class CameraHandler: NSObject{
    static let shared = CameraHandler()
    
    fileprivate var currentVC: UIViewController!
    
    var imagePickedBlock: ((UIImage) -> Void)?
    var imagePickedURL: URL?
    
    //showActionSheet()
    func showActionSheet(vc: UIViewController){
        currentVC = vc//vcは何？
        let actionSheet = UIAlertController(title: nil,message: nil, preferredStyle:.actionSheet) //読み込む形式選択アラート
        actionSheet.addAction(UIAlertAction(title:"Camera",style: .default, handler:{(alert: UIAlertAction!) -> Void in self.camera()})) //重要:アラートに機能を追加は:UIAlertController.addAction メソット！
        
        actionSheet.addAction(UIAlertAction(title:"Gallery",style:.default,handler:{
            (alert:UIAlertAction) -> Void in self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        vc.present(actionSheet, animated:true, completion: nil)
    }
    
    //camera()
    func camera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .camera
            currentVC.present(myPickerController, animated: true,
                              completion:nil)
        }
    }
    
    //photoLibrary()
    func photoLibrary(){
        if
            UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .photoLibrary
            currentVC.present(myPickerController, animated: true, completion: nil)
        }
    }
    
}

extension CameraHandler: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any
        ]) {
        if let image = info [UIImagePickerControllerOriginalImage] as? UIImage{
            self.imagePickedBlock?(image)
        }else{
            print("Someting went Wrong")
        }
        if let imageUrl = info[UIImagePickerControllerMediaURL] as? URL{
            self.imagePickedURL = imageUrl
            
        }else{
            print("Something went wrong in  video")
        }
        currentVC.dismiss(animated:true, completion:nil)
     }
}

