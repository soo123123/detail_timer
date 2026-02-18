//
//  AlarmTime.swift
//  detail_timer
//
//  Created by Soo on 2/18/26.
//

import Foundation

struct AlarmTime: Identifiable, Codable{
    let id: UUID
    var time: LocalTime
}
