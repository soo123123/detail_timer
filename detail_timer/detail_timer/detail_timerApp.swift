//
//  detail_timerApp.swift
//  detail_timer
//
//  Created by Soo on 2/11/26.
//

import SwiftUI
import UserNotifications

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {

        return [.banner, .sound]
    }
}

@main
struct detail_timerApp: App {
    
    let notificationDelegate = NotificationDelegate()
    
    init() {
        UNUserNotificationCenter.current().delegate = notificationDelegate
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
