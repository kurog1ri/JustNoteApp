//
//  JustNoteApp.swift
//  JustNote
//
//  Created by   Kosenko Mykola on 31.01.2025.
//

import SwiftUI
import SwiftData

// MARK: - App Entry Point
@main
struct JustNoteApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Note.self, ReminderTemplate.self])
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NotesView(modelContext: modelContext)
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                           willPresent notification: UNNotification,
                           withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}

 



