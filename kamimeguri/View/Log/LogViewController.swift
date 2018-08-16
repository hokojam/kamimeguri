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
    var diaryResult: Results<Diary>!
    private var logArray = [LogData]()
    
    // カメラかlibraryで撮るものを保存、取得
    @IBOutlet weak var WrittingBtn: UIButton!
    @IBOutlet weak var PostList: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createData()
        //updateList()
        //self.PostList.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func loadItems(){
            diaryResult = realm.objects(Diary.self)
            self.PostList.reloadData()
        }
        
    }
    func createData(){
        diaryResult = realm.objects(Diary.self)
        //let diaryObjects = realm.objects(Diary.self)
        for diaryObject in diaryResult {
            let logData = LogData(diary: diaryObject)
            logArray.insert(logData,at:0)
            //logArray.append(logData)
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
            //diaryObjects = realm.objects(Diary.self)
            return diaryResult?.count ?? 0//if nil return 1 : nil Coalescing Operator! important to make the app safer coz it wont crash eventhough nil
        }
        
        //cell表示
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //cellを取得
            //print(diaryResult.count)
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell {
                
                //let logData = logArray[indexPath.row]
                let logData = logArray [indexPath.row]
                cell.logData = logData
                return cell
            }
            return UITableViewCell()
        }
    }
    //logArray.count
    extension LogViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){//segueの名前は遷移を実行するものの名前
            let logData = logArray[indexPath.row]
            performSegue(withIdentifier: "ToPostDetail", sender: logData)  
        }
}

