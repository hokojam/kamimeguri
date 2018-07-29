//
//  ViewController.swift
//  Calendar
//
//  Created by Kentarou on 2018/05/03.
//  Copyright © 2018年 rui chen. All rights reserved.
//

import UIKit
import RealmSwift

class CalendarController: UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    
    let dateManager = DateManager()
    let daysPerWeek = 7
    let cellMargin: CGFloat = 2.0
    var selectedDate = Date()
    let today = Date()
    let weekArray = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    
    enum SectionType: Int {
        case header
        case calendar
        
        static var count: Int {
            let allSection: [SectionType] = [.header, .calendar]
            return allSection.count
        }
    }
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dateBar: UIView!
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    
    
    let starList = ["1", "3", "5"] // APIで取得
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monthLabel.text = changeHeaderTitle(date: selectedDate)
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let type = SectionType(rawValue: section) else { return 0 }
        switch type {
        case .header: return daysPerWeek
        case .calendar: return dateManager.daysAcquisition
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as? CalendarCell,
            let type = SectionType(rawValue: indexPath.section) {
            
            if indexPath.row % 7 == 0 {
                cell.DateLabel.textColor = .red
            } else if indexPath.row % 7 == 6 {
                cell.DateLabel.textColor = UIColor.skyBlue()
            } else {
                cell.DateLabel.textColor = .gray
            }
            
            switch type {
            case .header  :
                cell.DateLabel.text = weekArray[indexPath.row]
                cell.selectedDateImage.isHidden = true
            case .calendar:
                
                let day = dateManager.conversionDateFormat(indexPath: indexPath)
                cell.DateLabel.text = dateManager.conversionDateFormat(indexPath: indexPath)
                if let day = Int(day) {
                    if indexPath.row < 7 && day > 10 { //viewにはありますがその月の日付ではなければ空白になる
                        cell.DateLabel.text = ""
                    }
                    if indexPath.row > 20 && day < 7 {
                        cell.DateLabel.text = ""
                    }
                }
                cell.selectedDateImage.isHidden = starList.contains(cell.DateLabel.text!) ? false : true
            }
            
           if starList.contains(cell.DateLabel.text!) {
            cell.DateLabel.textColor = .white
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfMargin: CGFloat = 8.0
        let width = (collectionView.frame.size.width - cellMargin * numberOfMargin) / CGFloat(daysPerWeek)
        let height = width * 1.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    } 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    @IBAction func tapPrev(_ sender: UIButton) {if let date = dateManager.prevMonth(date: selectedDate) {
            selectedDate = date
            calendarCollectionView.reloadData()
           monthLabel.text = changeHeaderTitle(date: selectedDate)
        
        }
    }
    @IBAction func tapNext(_ sender: UIButton) {
        if let date = dateManager.nextMonth(date: selectedDate) {
            selectedDate = date
            calendarCollectionView.reloadData()
            monthLabel.text = changeHeaderTitle(date: selectedDate)
        }
    }
    
    func changeHeaderTitle(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM.yyyy"
        let selectMonth = formatter.string(from: date)
        return selectMonth
    }
    
    
    
    
}


