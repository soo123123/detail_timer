//
//  LocalTime.swift
//  detail_timer
//
//  Created by Soo on 2/18/26.
//

struct LocalTime: Codable, Comparable {
    let hour: Int
    let minute: Int
    
    static func < (lhs: LocalTime, rhs: LocalTime) -> Bool {
        if lhs.hour != rhs.hour {
            return lhs.hour < rhs.hour
        }
        return lhs.minute < rhs.minute
    }
}
