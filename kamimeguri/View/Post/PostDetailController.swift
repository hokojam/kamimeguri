//
//  PostDetailController.swift
//  kamimeguri
//
//  Created by Chen Rui on 2018/07/22.
//  Copyright © 2018 Chen Rui. All rights reserved.
//

import UIKit

class PostDetailController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let imageTitle = ["境内風景", "御朱印写真", "おみくじ写真"]
    enum SectionType: Int {
        case title
        case image
        case text
        
        static var count: Int {
            let type: [SectionType] = [.title, .image, .text]
            return type.count
        }
    }
    
    var logData: LogData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

extension PostDetailController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.count
    }
    //PostDetailTextCell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = SectionType(rawValue: section) else { return 0 }
        switch sectionType {
        case .title: return 1
        case .image: return imageTitle.count
        case .text: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = SectionType(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch sectionType {
        case .title:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailTitleCell", for: indexPath) as? PostDetailTitleCell {
                cell.logData = logData
                return cell
            }
            
        case .image:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailImageCell", for: indexPath) as? PostDetailImageCell {
                cell.imageTitle.text = imageTitle[indexPath.row]
                cell.postImage.image = logData?.images[indexPath.row]
                cell.noPhotoMessage.isHidden = true
                if cell.postImage.image == nil{
                        cell.noPhotoMessage.isHidden = false
                    }
                return cell
            }
            
        case .text:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailTextCell", for: indexPath) as? PostDetailTextCell {
                cell.PostTextTitle.text = "心の響き"
                cell.PostTextContent.text = logData?.postedText
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
    
}
