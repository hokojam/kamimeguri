//
//  CalendarDate.swift
//  kamimeguri
//
//  Created by Chen Rui on 2018/07/06.
//  Copyright © 2018 Chen Rui. All rights reserved.
//
//

import Foundation

extension Date {
    
    func monthAgoDate() -> Date? {
        let addValue = -1
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = addValue
        return calendar.date(byAdding: dateComponents, to: self)
    }
    
    func monthLaterDate() -> Date? {
        let addValue = 1
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = addValue
        return calendar.date(byAdding: dateComponents, to: self)
    }
}
