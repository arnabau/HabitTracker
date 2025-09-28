//
//  Habit.swift
//  HabitTracker
//
//  Created by Arnaldo Baumanis on 9/26/25.
//

import SwiftUI
import SwiftData

@Model
class Habit {
    var name: String
    var frequencies: [HabitFrequency]
    var createdAt: Date = Date()
    var completedDates: [TimeInterval] = []
    var notificationIDs: [String] = []
    var notificationTiming: Date?
    var uniqueID: String = UUID().uuidString
    
    init(name: String, frequencies: [HabitFrequency], notificationIDs: [String], notificationTiming: Date? = nil) {
        self.name = name
        self.frequencies = frequencies
        //self.createdAt = createdAt
        //self.completedDates = completedDates
        self.notificationIDs = notificationIDs
        self.notificationTiming = notificationTiming
        //self.uniqueID = uniqueID
    }
    
    var isNotificationEnabled: Bool {
        return !notificationIDs.isEmpty && notificationTiming != nil
    }
}

