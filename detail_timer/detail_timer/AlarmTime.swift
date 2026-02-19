//
//  AlarmTime.swift
//  detail_timer
//
//  Created by Soo on 2/18/26.
//

import Foundation

// 알람 하나의 시각을 나타냄
// id: UUID && Identifiable == SwiftUI에서 리스트를 만들 때 필요함.
struct AlarmTime: Identifiable, Codable{ // Identifiable && Codable == Protocol
    // id && time == Property
    let id: UUID
    var time: LocalTime
}
