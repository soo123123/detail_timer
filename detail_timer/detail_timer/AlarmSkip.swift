//
//  AlarmSkip.swift
//  detail_timer
//
//  Created by Soo on 2/19/26.
//

import Foundation

extension AlarmGroup {
    
    mutating func skipToday(calendar: Calendar = .current) {
        cleanupPastSkipDates(calendar: calendar)
        let today = calendar.startOfDay(for: Date())
        skipDates.insert(today)
    }
    
    func isSkipped(on date: Date, calendar: Calendar = .current) -> Bool {
        let day = calendar.startOfDay(for: date)
        return skipDates.contains(day)
    }
    
    mutating func unskipToday(calendar: Calendar = .current) {
        let today = calendar.startOfDay(for: Date())
        skipDates.remove(today)
    }
    
    mutating func cleanupPastSkipDates(calendar: Calendar = .current, reference: Date = Date()) {
        let today = calendar.startOfDay(for: reference)
        skipDates = skipDates.filter {$0 >= today}
    }
}
