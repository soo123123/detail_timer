//
//  LocalTime.swift
//  detail_timer
//
//  Created by Soo on 2/18/26.
//

// 값 자체가 중요, 상속 필요 없기에 구조체 사용.
// Date는 특정 시점을 표현, but 하루 안의 시간만 필요하기에 분리한 것.
struct LocalTime: Codable/*저장/불러오기*/, Comparable/*비교 연산자 사용 가능*/ {
    //hour && minute == 저장 프로퍼티
    let hour: Int
    let minute: Int
    
    static func < (lhs: LocalTime, rhs: LocalTime) -> Bool /*알람 시간 계산을 위한 순수 데이터 모델*/{
        if lhs.hour != rhs.hour {
            return lhs.hour < rhs.hour
        }
        return lhs.minute < rhs.minute
    }
}
