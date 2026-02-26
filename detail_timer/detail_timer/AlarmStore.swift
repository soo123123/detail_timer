//
//  AlarmStore.swift
//  detail_timer
//
//  Created by Soo on 2/25/26.
//

import Foundation

final class AlarmStore {
    // 싱글톤 패턴
    static let shared = AlarmStore()
    private init() {}
    
    private let fileName = "alarm_groups.json"
    
    // 저장 위치 계산
    private var fileURL : URL {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent(fileName)
    }
    
    //json 데이터 -> 객체
    func load() -> [AlarmGroup] {
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode([AlarmGroup].self, from: data)
        } catch {
            return []
        }
    }
    
    // 객체 -> json 데이터 -> 저장
    func save(_ groups: [AlarmGroup]) {
        do {
            let data = try JSONEncoder().encode(groups)
            try data.write(to: fileURL, options: [.atomic])
        } catch {
            print("save error:", error)
        }
    }
}
