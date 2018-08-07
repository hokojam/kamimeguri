//
//  WritingViewController.swift
//  kamimeguri
//
//  Created by Chen Rui on 2018/07/16.
//  Copyright © 2018 Chen Rui. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

let fileManager = FileManager.default
// Pathを生成
let path = Bundle.main.path(forResource: "sample", ofType: "txt")
let data = FileManager.default.contents(atPath: path!)
//let writingdata = WtirtingData(img)
class WritingViewController: UIViewController, UITextViewDelegate
{
    
    //databaseのための追加
    
    let realm = try! Realm()
    var diaryArray: Results<Diary>!//!がないと、Class 'WritingViewController' has no initializers
    
    
    var nowpostDate = UILabel()
    
    @IBOutlet weak var TempleName: UILabel!
    
    @IBOutlet weak var TempleAddress: UILabel!
    
    @IBOutlet weak var WritingScroll: UIScrollView!
    
    @IBOutlet var WishButton: [UIButton]!
    
    @IBAction func WishBtnTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var ScenceBtn: UIButton!
    
    @IBOutlet weak var ScenceImg: UIImageView!
    @IBOutlet weak var SyuinImage: UIImageView!
    @IBOutlet weak var SyuinBtn: UIButton!
    @IBOutlet weak var KujiBtn: UIButton!
    @IBOutlet weak var KujiImage: UIImageView!
    @IBOutlet weak var DiaryText: UITextView!
    
    @IBAction func ScenceBtnTapped(_ sender: UIButton) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.ScenceImg.image = image
            self.ScenceBtn.isHidden = true
        }
    }
    
    //以下textFieldのfunc
    // 編集中のテキストフィールド
    var editingField:UITextField?
    // 重なっている高さ
    var overlap:CGFloat = 0.0
    var lastOffsetY:CGFloat = 0.0
    // 編集開始のデリゲートメソッド
    private func textFieldDidBeginEditing(_ textField: UITextField) {
        // 編集中のテキストフィールド
        DiaryText.text = ""
        editingField = textField
    }
    
    // 編集終了のデリゲートメソッド
    private func textFieldDidEndEditing(_ textField: UITextField) {
        editingField = nil
    }
    
    // 改行の入力のデリゲートメソッド
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true) // キーボードを下げる
        // 改行コードは入力しない
        return false
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DiaryText.placeholder = "お参りの気持ちはどうですか?"
        DiaryText.delegate = self
        
        // スワイプでスクロールさせたならばキーボードを下げる
        WritingScroll.keyboardDismissMode = .onDrag
        // デフォルトの通知センターを得る
        let notification = NotificationCenter.default
        
        // キーボードのframeが変化した
        NotificationCenter.default.addObserver(self, selector: #selector(WritingViewController.keyboardDidChange(notification:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        // キーボードが登場した
        notification.addObserver(self,
                                 selector: #selector(WritingViewController.keyboardDidChange(notification:)),
                                 name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        // キーボードが退場した
        notification.addObserver(self,
                                 selector: #selector(WritingViewController.keyboardDidChange(notification:)),//なんでnotification: を追加しの？？？
            name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    @objc func keyboardDidChange(notification: Notification) {
        print("keyboardDidChange \(notification.name)")
        
        // Actual keyboard height
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        // Show or Hide
        
        if notification.name == Notification.Name.UIKeyboardWillShow ||
            notification.name == Notification.Name.UIKeyboardWillChangeFrame {
            view.frame.origin.y = -keyboardRect.height
        } else {
            view.frame.origin.y = 0
        }
    }
    
    
    func hideKeyboard(){
        DiaryText.resignFirstResponder()
    }
    
    
    @IBAction func SyuinBtnTapped(_ sender: UIButton) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.SyuinImage.contentMode = .scaleAspectFill
            //image.centerY =  self.SyuinImage.frame.centerY
            self.SyuinImage.image = image
            self.SyuinBtn.isHidden = true
        }
    }
    
    class SaveImgName{
        var imageName : String?
    }
    
    @IBAction func MikujiBtnTapped(_ sender: UIButton) {
        //CameraHandler.shared.imageData
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in //これどうなるの
            self.KujiImage.image = image
            self.KujiBtn.isHidden = true
            //Missing argument for parameter 'data' in call
        }
    }
    
    
    @IBAction func postBtn(_ sender: UIButton) {
        // キーボードを閉じる
        DiaryText.endEditing(true)
        
        let newDiary = Diary()
        newDiary.DiaryText = DiaryText.text
        newDiary.postTempleName = TempleName.text!
        newDiary.postTempleAddress = TempleAddress.text!
        
        
        let postDateFormatter =  DateFormatter()
        postDateFormatter.setTemplate(.fullDate)
        let postDate: String = "\(postDateFormatter.string(from: Date()))"
        nowpostDate.text = postDate
        newDiary.date = postDate
        newDiary.dateInfo = Date()//postDateFormatter.date(from: postDate)!
        newDiary.date = nowpostDate.text!
        
        self.saveItems(diary: newDiary)
        self.loadItems()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    func saveItems(diary: Diary){
        do{
            try realm.write{
                var latestId = 0
                if (false == realm.isEmpty) {
                    latestId = (realm.objects(Diary.self).max(ofProperty: "id") as Int?)!//.max(ofProperty: "id")がわかりません
                    latestId += 1
                    diary.id = latestId
                }  else if (true == realm.isEmpty) {
                    diary.id = latestId
                }
                
                
                let wiritngData = WiringData(id:latestId)
                if let ScenceImgSavetoFile = UIImagePNGRepresentation(self.ScenceImg.image!),
                    !FileManager.default.fileExists(atPath: wiritngData.scencePhotoPath){
                    // writes the image data to disk
                    try! ScenceImgSavetoFile.write(to: wiritngData.scencePhotoURL!)
                    diary.scencePhotoPath = wiritngData.scencePhotoPath
                    return
                }
    
                if let KujiImgSavetoFile = UIImagePNGRepresentation(self.KujiImage.image!),
                    !FileManager.default.fileExists(atPath: wiritngData.kujiPhotoPath){
                     try! KujiImgSavetoFile.write(to: wiritngData.kujiPhotoURL!)
                    diary.kujiPhotoPath = wiritngData.kujiPhotoPath
                    return
                }
                
                
                if let SyuinImgSavetoFile = UIImagePNGRepresentation(self.SyuinImage.image!),
                    !FileManager.default.fileExists(atPath: wiritngData.syuinPhotoPath){
                        try! SyuinImgSavetoFile.write(to: wiritngData.syuinPhotoURL!)
                        diary.syuinPhotoPath = wiritngData.syuinPhotoPath
                        return
                    }
                //realm.deleteAll() //テスト用。データベースをクリア
                realm.add(diary, update: true)
            }
            
        }
            
        catch {
            let alert = UIAlertController(title:"Add New TO DO item",message:"",
                                          preferredStyle: .alert)
            //alert.addAction(action)
            present(alert, animated: true, completion:nil)
        }
    }
    
    func loadItems(){
        diaryArray = realm.objects(Diary.self)
        //Cannot assign value of type 'Results<Diary>' to type '[Diary]'
        LogViewController().PostList.reloadData()
    }
}

