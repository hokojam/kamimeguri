//
//  LogController.swift
//  kamimeguri
//
//  Created by Chen Rui on 2018/07/04.
//  Copyright © 2018 Chen Rui. All rights reserved.
//

import UIKit
import RealmSwift

class LogViewController:  UIViewController {
    let realm = try! Realm()
    var diaryArray: Results<Diary>?
    private var dataArray: [LogData] = []
    
    // カメラかlibraryで撮るものを保存、取得
    @IBOutlet weak var WrittingBtn: UIButton!
    @IBOutlet weak var PostList: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createData()
    }
    
    func createData() {
        let diary = Diary()
        let diaryObjects = realm.objects(Diary.self)
        for diaryObject in diaryObjects{
            let logData = LogData() //logdataに関する定義は別のファイルで
            logData.photo1 = UIImage(named: "img_scence")
            logData.photo2 = UIImage(named: "img_kuji")
            logData.photo3 = UIImage(named: "img_syuin")
            
            
            let yearInfo = DateFormatter()
            yearInfo.setTemplate(.Year)
            logData.postYear = yearInfo.string(from: diary.dateInfo as Date)
            //formatter.stringFromDate(time)
            
            let MDINfo = DateFormatter()
            MDINfo.setTemplate(.MDDate)
            logData.postDate = MDINfo.string(from: diary.dateInfo as Date)
            
            let weekdayInfo = DateFormatter()
            weekdayInfo.setTemplate(.weekDay)
            logData.postWeekly = weekdayInfo.string(from:diary.dateInfo as Date)
            
            logData.postTempleName = diary.postTempleName
            logData.postTempleAddress = diary.postTempleName
            
            if diary.DiaryText != nil {
                logData.postedText = diary.DiaryText!}
            dataArray.insert(logData, at:0)
            
            try! realm.write {
                realm.add(diaryObject, update: true)
                //return logData.count
            }
        }
       
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.PostList.reloadData() // データの再読み込み,ここでエラー出るかも
    }
    
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

