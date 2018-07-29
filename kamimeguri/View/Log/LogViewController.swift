//
//  LogController.swift
//  kamimeguri
//
//  Created by Chen Rui on 2018/07/04.
//  Copyright © 2018 Chen Rui. All rights reserved.
//

import UIKit

class LogViewController:  UIViewController {
      //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //UIApplicatio.shared
    private var dataArray: [LogData] = []
    
    // カメラかlibraryで撮るものを保存、取得
    @IBOutlet private weak var WrittingBtn: UIButton!
    @IBOutlet private weak var PostList: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createData()
    }
    
    func createData() {
        let diary = Diary()
        for _ in 0..<10 {
            let logData = LogData() //logdataに関する定義は別のファイルで
            logData.photo1 = UIImage(named: "img_scence")
            logData.photo2 = UIImage(named: "img_kuji")
            logData.photo3 = UIImage(named: "img_syuin")
            
            let yearInfo = DateFormatter()
            yearInfo.setTemplate(.Year)
            logData.postYear = yearInfo.string(from:diary.dateInfo)
            //formatter.stringFromDate(time)
            let MDINfo = DateFormatter()
            MDINfo.setTemplate(.MDDate)
            logData.postDate = "\(MDINfo.string(from: diary.dateInfo))"
            
            let weekdayInfo = DateFormatter()
            weekdayInfo.setTemplate(.weekDay)
            logData.postWeekly = "\(weekdayInfo.string(from: diary.dateInfo))"
            
            logData.postTempleName = "東京大神宮"
            logData.postTempleAddress = "東京都千代田区富士見２丁目４−１"
            dataArray.insert(logData, at:0)
        }
        
//        let realm
//        try! realm.write {
//            realm.add(dataArray, update: true)
//        }
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
        return dataArray.count
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

