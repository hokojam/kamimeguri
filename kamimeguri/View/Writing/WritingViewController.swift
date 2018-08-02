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

class WritingViewController: UIViewController, UITextViewDelegate
{
    
    //databaseのための追加
    
    let realm = try! Realm()
    //private var dataArray: [LogData] = []
    var diaryArray: Results<Diary>!//!がないと、Class 'WritingViewController' has no initializers
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
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
    
//    if let Iimage = info[UIImagePickerControllerOriginalImage] as? UIImage{
//        let imageData = UIImageJPEGRepresentation(Iimage, 1)
    
    //撮影ボタン
//    class MyImageStorage{
//        var imagePath: NSString?
//        func getImageData(info:[String : Any]) -> Data {
//            if let Iimage = info[self.SyuinImage.image] {
//                let imageData = UIImageJPEGRepresentation(Iimage, 1)
//            }
//            return imageData
//
//        let url = NSURL(string: "")!
//        if let imgData = NSData(contentsOfURL: url) {
//            // Storing image in documents folder (Swift 2.0+)
//            let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
//            let writePath = documentsPath?.stringByAppendingPathComponent("myimage.jpg")
//
//            imgData.writeToFile(writePath, atomically: true)
//
//            var mystorage = MyImageStorage()
//            mystorage.imagePath = writePath
//    }
//
    
    
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
            var saveImgName = SaveImgName()
            var diary = Diary()
            saveImgName.imageName = saveImage(imgTitle: "Mikuji", id: Diary().id, data: Data)  //self.SyuinImage.image
        }
    }
    
   
    @IBAction func postBtn(_ sender: UIButton) {
        // キーボードを閉じる
        DiaryText.endEditing(true)
      
        let newDiary = Diary()

        // 内容を反映する
        newDiary.DiaryText = DiaryText.text
      
       
        newDiary.postTempleName = TempleName.text!
        newDiary.postTempleAddress = TempleAddress.text!
         //newDiary.date = nowpostDate.text!
        let postDateFormatter =  DateFormatter()
        postDateFormatter.setTemplate(.fullDate)
        let postDate: String = "\(postDateFormatter.string(from: Date()))"
        nowpostDate.text = postDate
        newDiary.date = postDate
        newDiary.dateInfo = postDateFormatter.date(from: postDate)! as NSDate

       
        
//                newDiary.scencePhoto = self.ScenceImg.image
//                newDiary.kujiPhoto = self.SyuinImage.image
//                newDiary.syuinPhoto = self.KujiImage.image
        //             let realm = try! realm.write {
        //             diary.realm?.add(diary, update: true)}
        self.saveItems(diary: newDiary)
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        self.dismiss(animated: true, completion: nil)
        //LogViewController().PostList.reloadData()
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    private func saveImage(imgTitle:String, id:Int, data:Data) -> String {
        let imageName = "\(imgTitle)" + "\(id)" + ".jpg"
        let filename = getDocumentsDirectory().appendingPathComponent(imageName)
        try? data.write(to: filename)
        return imageName
    }
    
    func saveItems(diary: Diary){
        
        do{
            try realm.write{
                var latestId = 0
                if (false == realm.isEmpty) {
                    latestId = (realm.objects(Diary.self).max(ofProperty: "id") as Int?)!//.max(ofProperty: "id")がわかりません
                    latestId += 1
                    diary.id = latestId
                }
//                if (nil != imageData) {
//                    diary.imageName = imageManager.saveImage(data, id: diary.id)
//                }
                realm.add(diary, update: true)
            }
            
        }
        catch{
            let alert = UIAlertController(title:"Add New TO DO item",message:"",
                                          preferredStyle: .alert)
            //alert.addAction(action)
            present(alert, animated: true, completion:nil)
           }
        //
       }
    
    func loadItems(){
     diaryArray = realm.objects(Diary.self)
        //Cannot assign value of type 'Results<Diary>' to type '[Diary]'
     LogViewController().PostList.reloadData()
   }
}
