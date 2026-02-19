//
//  AlarmGroup.swift
//  detail_timer
//
//  Created by Soo on 2/18/26.
//

import Foundation

// 알람들을 묶는 그룹 모델
struct AlarmGroup: Identifiable, Codable {
    let id: UUID
    var name: String // 화면에 표시되는 그룹 이름.
    var repeatDays: Set<Weekday> // 반복 요일, Set을 쓴 이유 == 중복방지, 포함 여부 체크가 빠름.
    
    var enabled: Bool // 그룹 전체 활성화 여부
    var skipDates: Set<Date> // 특정 날짜에는 알람을 울리지 않도록 예외 처리
    var times: [AlarmTime] // 그 그룹에 포합된 여러 알람 시각.
}
