//
//  ContentView.swift
//  detail_timer
//
//  Created by Soo on 2/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var groups: [AlarmGroup] = []
    // ui에서 화면에 그려질 내용을 정의하는 프로퍼티
    // some View == 어떤 View타입을 반환한다는 의미
    var body: some View {
        // 세로 방향 스택 레이아웃(일단 개념이해 스킵)
        VStack(spacing: 16) {
            // 상태 텍스트
            if let group = groups.first{
                Text(group.name)
                Text(group.isSkipped(on: Date()) ? "오늘: 스킵됨" : "오늘: 정상")
                
                Button("2분 뒤 테스트 알람 생성(안정)") {
                    let calendar = Calendar.current
                    let now = Date()

                    // 1) 다음 분의 00초로 올림
                    let nextMinute = calendar.nextDate(
                        after: now,
                        matching: DateComponents(second: 0),
                        matchingPolicy: .nextTime
                    )!

                    // 2) 거기서 +2분 (경계 안전)
                    let target = calendar.date(byAdding: .minute, value: 2, to: nextMinute)!

                    let hour = calendar.component(.hour, from: target)
                    let minute = calendar.component(.minute, from: target)

                    let weekdayValue = calendar.component(.weekday, from: target)
                    guard let todayWeekday = Weekday(rawValue: weekdayValue) else { return }

                    let testGroup = AlarmGroup(
                        id: UUID(),
                        name: "2분 테스트",
                        repeatDays: [todayWeekday],
                        enabled: true,
                        skipDates: [],
                        times: [
                            AlarmTime(id: UUID(), time: LocalTime(hour: hour, minute: minute))
                        ]
                    )

                    groups = [testGroup]
                    AlarmStore.shared.save(groups)

                    Task {
                        await AlarmNotificationScheduler.shared.rescheduleAll(groups: groups)
                        // 예약이 실제로 들어갔는지 확인하고 싶으면(디버그 함수 있을 때)
                        // await AlarmNotificationScheduler.shared.debugPrintPendingAll()
                    }
                }
                
                Button("오늘만 끄기") {
                    groups[0].skipToday()
                    AlarmStore.shared.save(groups)

                    Task {
                        await AlarmNotificationScheduler.shared.rescheduleAll(groups: groups)
                    }
                }
                
                Button("오늘 스킵 해제") {
                    groups[0].unskipToday()
                    AlarmStore.shared.save(groups)
                }
                
            }
            else {
                Button("테스트 그룹 생성") {
                    /*let g = AlarmGroup(
                        id: UUID(),
                        name: "평일 8시",
                        repeatDays: [.monday, .tuesday, .wednesday, .thursday, .friday],
                        enabled: true,
                        skipDates: [],
                        times: [
                            AlarmTime(id: UUID(), time: LocalTime(hour: 8, minute: 0))
                        ]
                    )
                    groups = [g]
                    AlarmStore.shared.save(groups)*/
                }
            }
            Button("다음 알람 계산") {
                if let next = groups.first?.nextTriggerDate(from: Date()) {
                    print("Next:", next)
                } else {
                    print("No upcoming alarms.")
                }
            }
        }
        //Vstack을 만들고 padding으로 감싸라
        .padding()
        .onAppear {
            groups = AlarmStore.shared.load()
            
            Task {
                let ok = await AlarmNotificationScheduler.shared.requestAuthorization()
                if ok {
                    await AlarmNotificationScheduler.shared.rescheduleAll(groups: groups)
                }
            }
        }
    }
}

