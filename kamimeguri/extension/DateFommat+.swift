//
//  DateFommat+.swift
//  kamimeguri
//
//  Created by Chen Rui on 2018/07/29.
//  Copyright © 2018 Chen Rui. All rights reserved.
//

import Foundation

extension DateFormatter{
    enum Template: String{
        case weekDay = "EEEE"
        case MDDate = "MMM/dd"
        case Year = "YYYY"
        case fullDate = "YYYY-MMM-dd-EEEE"
    }
    func setTemplate(_ template: Template) {
        dateFormat = DateFormatter.dateFormat(fromTemplate: template.rawValue, options: 0, locale: .current)
    }
}
