//
//  ContentView.swift
//  detail_timer
//
//  Created by Soo on 2/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var group = AlarmGroup(
        id: UUID(),
        name: "평일",
        repeatDays: Set(Weekday.allCases),
        enabled: true,
        skipDates: [],
        times: []
    )

    var body: some View {
        VStack(spacing: 16) {
            Text(group.isSkipped(on: Date()) ? "오늘: 스킵됨" : "오늘: 정상")

            Button("오늘만 끄기") {
                group.skipToday()
            }

            Button("오늘 스킵 해제") {
                group.unskipToday()
            }
        }
        .padding()
    }
}
