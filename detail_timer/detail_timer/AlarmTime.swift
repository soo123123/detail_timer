//
//  AlarmTime.swift
//  detail_timer
//
//  Created by Soo on 2/18/26.
//

import Foundation // UUID 사용을 위해 필요함.

// 알람 하나의 시각을 나타냄
// id: UUID && Identifiable == SwiftUI에서 리스트를 만들 때 필요함.
struct AlarmTime: Identifiable, Codable{ // Identifiable && Codable == Protocol
    // id && time == Property
    //실제 프로퍼티를 구현한 것.
    let id: UUID
    var time: LocalTime
}
