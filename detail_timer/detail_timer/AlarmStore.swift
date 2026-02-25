//
//  AlarmStore.swift
//  detail_timer
//
//  Created by Soo on 2/25/26.
//

import Foundation

final class AlarmStore {
    static let shared = AlarmStore()
    private init() {}
    
    private let fileName = "alarm_groups.json"
    
    private var fileURL : URL {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent(fileName)
    }
    
    func load() -> [AlarmGroup] {
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode([AlarmGroup].self, from: data)
        } catch {
            return []
        }
    }
    
    func save(_ groups: [AlarmGroup]) {
        do {
            let data = try JSONEncoder().encode(groups)
            try data.write(to: fileURL, options: [.atomic])
        } catch {
            print("save error:", error)
        }
    }
}
