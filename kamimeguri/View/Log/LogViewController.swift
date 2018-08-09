//
//  LogController.swift
//  kamimeguri
//
//  Created by Chen Rui on 2018/07/04.
//  Copyright © 2018 Chen Rui. All rights reserved.
// Log一覧のUIに関する反映。Logの配列にdiaryのデータを表示する、UITableViewの設定とか

import UIKit
import RealmSwift

class LogViewController:  UIViewController {
    let realm = try! Realm()
    var diaryArray: Results<Diary>?
    private var dataArray: [LogData] = []
    
    // カメラかlibraryで撮るものを保存、取得
    @IBOutlet weak var WrittingBtn: UIButton!
    @IBOutlet weak var PostList: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createData()
        //updateList()
        self.PostList.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

//    private let log = Logger(logPlace: DiaryRepository.self)
//    private var realm = try! Realm()
//    private let fileManager = FileManager.default
//    private let imageManager = ImageFileManager.sharedInstance
//
//    private override init() {
//        super.init()
//    }
    func getAllList() -> Results<Diary> {
        let diarys:Results<Diary> = realm.objects(Diary.self)
        return diarys
    }

//    func updateList() {
//        if self.realm.objects(Diary.self).count == 0 {
//
//            let list = Diary()
////            list.id = "000001"
////            list.text = "lista de prueba"
//
//            // Add to the Realm inside a transaction
//            try! self.realm.write {
//                self.realm.add(list)
//            }
//
//        }
//        if diaryArray == nil, let firstDiary = self.realm.objects(Diary.self).first {
//            dataArray = list //diaryArrayは新しいdiary
//        }
//        self.PostList.reloadData()
//    }
    
    func createData() { //ここのViewでDiaryの数だけでLogの配列を生成しよう
        let diaryObjects = realm.objects(Diary.self)
        for diaryObject in diaryObjects{
            let logData =  LogData(diary: diaryObject)
            if diaryArray == nil, let firstDiary = self.realm.objects(Diary.self).first {
                    try! realm.write {
                        realm.add(firstDiary, update: true)
                    }
            }else{
            dataArray.append(logData!)
              }
            }
        }

    //遷移するときにデータを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let postDetail = segue.destination as? PostDetailController,
            let logData = sender as? LogData {
            postDetail.logData = logData
        }
    }
}

extension LogViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let diaryObjects = realm.objects(Diary.self)
        return diaryObjects.count //if nil return 1 : nil Coalescing Operator! important to make the app safer coz it wont crash eventhough nil
    }
    
    //cell表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //cellを取得
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell {
            let logData = dataArray[indexPath.row]
            cell.logData = logData
            return cell
        }
        return UITableViewCell()
    }
}

extension LogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){//segueの名前は遷移を実行するものの名前
        let logData = dataArray[indexPath.row]
        performSegue(withIdentifier: "ToPostDetail", sender: logData)
        
    }
}

