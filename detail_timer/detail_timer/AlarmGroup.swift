//
//  AlarmGroup.swift
//  detail_timer
//
//  Created by Soo on 2/18/26.
//

import Foundation

struct AlarmGroup: Identifiable, Codable {
    let id: UUID
    var name: String
    var repeatDays: Set<Weekday>
    var enabled: Bool
    var skipDates: Set<Date>
    var times: [AlarmTime]
}
