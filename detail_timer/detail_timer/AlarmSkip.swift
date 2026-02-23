//
//  AlarmSkip.swift
//  detail_timer
//
//  Created by Soo on 2/19/26.
//

import Foundation

extension AlarmGroup { //상속
    
    //오늘 하루 이 그룹 알람 전부 스킵
    mutating func skipToday(calendar: Calendar = .current) { // .current == 사용자의 현재 설정을 따르는 달력 객체
        cleanupPastSkipDates(calendar: calendar) // 오늘 이전 날짜들은 정리
        let today = calendar.startOfDay(for: Date()/*현재 시각*/) // today를 자정기준으로 정규화
        skipDates.insert(today) // 스킵목록에 today 삽입
    }
    
    // 특정 날짜가 스킵 상태인지 확인
    func isSkipped(on date: Date, calendar: Calendar = .current) -> Bool {
        let day = calendar.startOfDay(for: date) // 비교 할 날짜 자정 기준으로 변환
        return skipDates.contains(day)
    }
    
    // 오늘 스킵 취소
    mutating func unskipToday(calendar: Calendar = .current) {
        let today = calendar.startOfDay(for: Date())
        skipDates.remove(today) // 스킵목록에서 today 삭제
    }
    
    // 오늘 이전 날짜들은 삭제
    mutating func cleanupPastSkipDates(calendar: Calendar = .current, reference: Date = Date()/*변수명: 타입 = 값*/) {
        let today = calendar.startOfDay(for: reference) // 기준 날짜 == 자정
        
        // 익명함수 표현식 들어갔는데 일단 이해 없이 넘어가도 될듯.
        skipDates = skipDates.filter {$0 >= today} // 과거 날짜 정리
    }
    
    func shoudRing(at  date: Date, calendar: Calendar = .current) -> Bool {
        //guard문 : 조건이 false면 else 실행.
        
        // 조건1: enabled가 true여야 함.
        guard enabled else {return false}
        
        // 조건2: isSkipped가 true여야 함.
        guard !isSkipped(on: date, calendar: calendar) else {return false}
        
        // component의 return값은 int형
        let weekdayNumber = calendar.component(.weekday, from: date) // 오늘이 무슨 요일인지 숫자로 반환
        
        //조건3: 열거형에 값을 저장하고 변수에 해당 값 복사가 true여야 함.(예외처리 느낌)
        guard let weekday = Weekday(rawValue: weekdayNumber) else {
            return false
        }
        
        //조건4: repeatDays에 weekday값이 있어야 함. contains의 return이 bool임.
        guard repeatDays.contains(weekday) else {return false}
        
        return true
    }
}
