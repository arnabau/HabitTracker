//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Arnaldo Baumanis on 9/25/25.
//

import SwiftUI
import SwiftData

@main
struct HabitTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Habit.self)
        }
    }
}
