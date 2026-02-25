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

                Button("오늘만 끄기") {
                    groups[0].skipToday()
                    AlarmStore.shared.save(groups)
                }

                Button("오늘 스킵 해제") {
                    groups[0].unskipToday()
                    AlarmStore.shared.save(groups)
                }
            
            }
            else {
            Button("테스트 그룹 생성") {
                let g = AlarmGroup(
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
                AlarmStore.shared.save(groups)
            }
        }
        .padding()
        .onAppear{
            groups = AlarmStore.shared.load()
        }
    }
}
