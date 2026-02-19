//
//  Weekday.swift
//  detail_timer
//
//  Created by Soo on 2/18/26.
//

//각 요일을 표현하는 열거형
//Calender의 weekday 값과 맞추기 좋음.
enum Weekday: Int, CaseIterable, Codable {
    case sunday = 1
    case monday // = 2
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday    
}
