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
    
    // 지금 시각 기준으로, 앞으로 울릴 가장 가까운 알람 시각을 계산해서 반환하는 함수
    func nextTriggerDate(from now: Date) -> Date? {
        // 조건1: enabled == false -> else
        guard enabled else { return nil }
        
        let calendar = Calendar.current
        let todayKey = calendar.startOfDay(for: now)
        
        // 오늘 포함 7일간 반복
        for dayOffset in 0..<7 {
            // dayOffset만큼 day를 더한 날짜 만들기
            // candiateDay가 nil이 아니면 계속 실행
            guard let candidateDay = calendar.date(byAdding: .day, value:dayOffset, to: todayKey) else {
                continue
            }
            
            // candidateDay에서 week만 뽑아서 저장
            let weekdayValue = calendar.component(.weekday, from: candidateDay)
            
            // 숫자를 enum 타입으로 변환
            // 변환된 weekday가 반복요일 집합에 있는지 확인
            guard let weekday = Weekday(rawValue: weekdayValue), repeatDays.contains(weekday) else {
                continue
            }
            
            // 조건2: 스킵하기로 했다면 제외
            if skipDates.contains(candidateDay) {
                continue
            }
            
            // 그룹에 있는 시간을 기준으로 오름차순 정렬
            let sortedTimes = times.sorted()
            
            // 정렬값 변수에 저장
            for alarmTime in sortedTimes {
                var comps = calendar.dateComponents([.year, .month, .day], from: candidateDay)
                comps.hour = alarmTime.time.hour
                comps.minute = alarmTime.time.minute
                comps.second = 0
                
                // comps값이 nil이 아니면 값 저장
                guard let triggerDate = calendar.date(from: comps) else {
                    continue
                }
                
                // 첫 for문에서 오늘 중 다음 알람이 있는지 확인
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
