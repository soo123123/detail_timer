//
//  AlarmNotificationScheduler.swift
//  detail_timer
//
//  Created by Soo on 3/3/26.
//

import Foundation
import UserNotifications

final class AlarmNotificationScheduler {
    
    // 싱글톤 패턴
    static let shared = AlarmNotificationScheduler()
    private init(){}
    
    // ios예약 취소를 담당하는 시스템 객체
    private let center = UNUserNotificationCenter.current()
    
    private let schedulingHorizonDays = 7
    
    // 알람 권한 요청 (비동기)
    // 권한이 허용됐는지 여부를 리턴함.
    func requestAuthorization() async -> Bool {
        do {
            return try await center.requestAuthorization(options: [.alert, .sound, .badge])
        } catch {
            print("error:", error)
            return false
        }
    }
    
    // 전체 재예약 (비동기)
    func rescheduleAll(groups: [AlarmGroup]) async {
        await cancelAll(for: groups)
        await scheduleAll(groups: groups)
    }
    
    // 기존 예약 취소 (비동기)
    private func cancelAll(for groups: [AlarmGroup]) async {
        let ids = groups.flatMap {
            group in makeAllPossibleIdentifiers(for: group)
        }
        center.removePendingNotificationRequests(withIdentifiers: ids)
    }
    
    // 전체 예약
    private func scheduleAll(groups: [AlarmGroup]) async {
        for g in groups {
            await schedule(group: g)
        }
    }
    
    // 예약 함수 (비동기)
    func schedule(group: AlarmGroup, now: Date = Date()) async {
        guard group.enabled else { return }
        
        let calendar = Calendar.current
        let todayKey = calendar.startOfDay(for: now)
        
        for dayOffset in 0..<schedulingHorizonDays {
            
            // 오늘 + n일 계산
            guard let day = calendar.date(byAdding: .day, value: dayOffset, to: todayKey) else { continue }
            
            let weekdayValue = calendar.component(.weekday, from: day)
            
            // 알람 반복 요일에 포함되는지 확인
            guard let wd = Weekday(rawValue: weekdayValue), group.repeatDays.contains(wd) else { continue }
            
            // 사용자가 오늘만 끄기 한 날짜는 건너뜀
            if group.skipDates.contains(day) {continue}
            
            // 시간 오름차순 정렬
            let sortedTimes = group.times.sorted { $0.time < $1.time}
            
            // 실제 울릴 시각 계산
            for t in sortedTimes {
                var comps = calendar.dateComponents([.year, .month, .day], from: day)
                comps.hour = t.time.hour
                comps.minute = t.time.minute
                comps.second = 0
                
                guard let fireDate = calendar.date(from: comps) else { continue }
                
                // 이미 지난 시간 제외
                if fireDate <= now {continue}
                
                // 알람 내용 생성
                let content = UNMutableNotificationContent()
                content.title = group.name
                content.body = "\(t.time.hour)시 \(String(format: "%02d", t.time.minute))분"
                content.sound = .default
                
                // 트리거 생성
                let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
                
                // 고유 id 생성
                let id = makeIdentifier(groupId: group.id, timeId: t.id, day: day)
                let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
                do {
                    // 시스템에 등록
                    try await center.add(request)
                } catch {
                    print("error:", error)
                }
            }
        }
    }
    
    // 특정 알람 그룹이 앞으로 7일 동안 가질 수 있는 모든 알림 ID를 미리 만들어서 배열로 반환하는 함수
    private func makeAllPossibleIdentifiers(for group: AlarmGroup) -> [String]/*배열반환*/ {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        var ids: [String] = []
        for dayOffset in 0..<schedulingHorizonDays {
            
            // 오늘 00시를 기준으로 dayOffset만큼 날짜를 더함.
            guard let day = calendar.date(byAdding: .day, value: dayOffset, to: today) else {continue}
            
            // 각 알람 마다 고유 식별자를 만들어서 배열에 추가
            for t in group.times {
                ids.append(makeIdentifier(groupId: group.id, timeId: t.id, day: day))
            }
        }
        return ids
    }
    
    // 고유 식별자를 만드는 함수
    private func makeIdentifier(groupId: UUID, timeId: UUID, day: Date) -> String {
        let df = DateFormatter()
        df.calendar = Calendar.current
        df.timeZone = .current
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyyMMdd"
        
        return "alarm.\(groupId.uuidString).\(timeId.uuidString).\(df.string(from: day))"
    }
}
