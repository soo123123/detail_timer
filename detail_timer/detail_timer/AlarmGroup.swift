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
    var skipDates: Set<Date>/*Date == 절대 시간, 같은 날이여도 시간이 다르면 다른 값.*/ // 특정 날짜에는 알람을 울리지 않도록 예외 처리
    var times: [AlarmTime] // 그 그룹에 포합된 여러 알람 시각.
    
    
    func nextTriggerDate(from now: Date) -> Date? {
        guard enabled else { return nil }
        
        let calendar = Calendar.current
        let todayKey = calendar.startOfDay(for: now)
        
        for dayOffset in 0..<7 {
            guard let candidateDay = calendar.date(byAdding: .day, value:dayOffset, to: todayKey) else {
                continue
            }
            
            let weekdayValue = calendar.component(.weekday, from: candidateDay)
            guard let weekday = Weekday(/*this*/rawValue: weekdayValue), repeatDays.contains(weekday) else {
                continue
            }
            
            if skipDates.contains(candidateDay) {
                continue
            }
            
            let sortedTimes = times.sorted()
            
            for alarmTime in sortedTimes {
                var comps = calendar.dateComponents([.year, .month, .day], from: candidateDay)
                comps.hour = alarmTime.time.hour
                comps.minute = alarmTime.time.minute
                comps.second = 0
                
                guard let triggerDate = calendar.date(from: comps) else {
                    continue
                }
                
                if dayOffset == 0 {
                    if triggerDate > now {
                        return triggerDate
                    }
                } else {
                    return triggerDate
                }
            }
        }
        return nil
    }
}
