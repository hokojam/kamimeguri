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
//let path = Bundle.main.path(forResource: "sample", ofType: "txt")
//let data = FileManager.default.contents(atPath: path!)
//let writingdata = WtirtingData(img)
class WritingViewController: UIViewController, UITextViewDelegate
{
    //データに関連する変数
    let realm = try! Realm()
    var diaryArray: Results<Diary>!//!がないと、Class 'WritingViewController' has no initializers
    private let fileManager = FileManager.default
    var writingData = WritingData()
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
    
    @IBAction func ScenceBtnTapped(_ sender: UIButton) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.ScenceImg.image = image
            self.ScenceBtn.isHidden = true
        }
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
            try! realm.write{
             var latestId = getDiaryId()
             
                //idが生成されるたびに、新しいid用のdirectoryを生成する
                let photoSavePath = writingData?.initPath(id:latestId)

                //境内画像
                if let ScenceImgSavetoFile = UIImagePNGRepresentation(self.ScenceImg.image!)
                  {
                    //画像のpathを作る
                    let newScencePhotoPath = writingData?.getImagePath(path: photoSavePath, photoname: writingData?.scencePhotoName)
                    writingData?.saveImage(path:(newScencePhotoPath)!,imagedata:ScenceImgSavetoFile)//どう書き出すか考えよう
                    //PathをRealmに保存
                    diary.scencePhotoPath = newScencePhotoPath
                }else{
                    print ("画像がないですよ")
                }
    
                //おみくじの画像
                if let KujiImgSavetoFile = UIImagePNGRepresentation(self.KujiImage.image!)
                   {
                    let newKujiPhotoPath = writingData?.getImagePath(path: photoSavePath, photoname: writingData?.kujiPhotoName)
                    writingData?.saveImage(path:(newKujiPhotoPath)!,imagedata:KujiImgSavetoFile)
                    //PathをRealmに保存
                    diary.scencePhotoPath = newKujiPhotoPath
                }else{
                    print ("画像がないですよ")
                }
              
                
                if let SyuinImgSavetoFile = UIImagePNGRepresentation(self.SyuinImage.image!)
                    //,!FileManager.default.fileExists(atPath: writingData.syuinPhotoPath)
                {
                    //画像のパスを作る
                    let newSyuinPhotoPath = writingData?.getImagePath(path: photoSavePath, photoname: writingData?.syuinPhotoName)
                    writingData?.saveImage(path:(newSyuinPhotoPath)!,imagedata:SyuinImgSavetoFile)
                    //PathをRealmに保存
                    diary.syuinPhotoPath = newSyuinPhotoPath
                }else{
                    print ("画像がないですよ")
                }
                //realm.deleteAll() //テスト用。データベースをクリア
                realm.add(diary, update: true)
            }
            
            func getDiaryId() -> Int {
                var latestId = 1
                if (false == realm.isEmpty) {
                    latestId = (realm.objects(Diary.self).max(ofProperty: "id") as Int?)!//.max(ofProperty: "id")がわかりません
                    latestId += 1
                    diary.id = latestId
                }  else if (true == realm.isEmpty) {
                    diary.id = latestId
                }
                return latestId
            }
            
        }
        

    func loadItems(){
        diaryArray = realm.objects(Diary.self)
        LogViewController().PostList.reloadData()
    }
}

