//
//  LocalTime.swift
//  detail_timer
//
//  Created by Soo on 2/18/26.
//

// 날짜가 아닌 하루 안의 시각만 표현
struct LocalTime: Codable, Comparable {
    //hour && minute == property
    let hour: Int
    let minute: Int
    
    static func < (lhs: LocalTime, rhs: LocalTime) -> Bool {
        if lhs.hour != rhs.hour {
            return lhs.hour < rhs.hour
        }
        return lhs.minute < rhs.minute
    }
}
