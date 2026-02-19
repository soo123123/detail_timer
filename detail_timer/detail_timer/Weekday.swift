//
//  Weekday.swift
//  detail_timer
//
//  Created by Soo on 2/18/26.
//

//각 요일을 표현하는 열거형
//Calender의 weekday 값과 맞추기 좋음.
enum Weekday: Int/*각 case에 숫자 값을 연결*/, CaseIterable/*프로토콜 -> 배열형태로 한 번에 제공*/, Codable/*프로토콜 -> 저장/불러오기 기능.*/ { // A: B, C == B, C는 프로토콜 or raw type ?= enum && struct에서는 상속 아님.
    case sunday = 1
    case monday // = 2
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday    
}
