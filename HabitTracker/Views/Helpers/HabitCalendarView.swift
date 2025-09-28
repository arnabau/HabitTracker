//
//  HabitCalendarView.swift
//  HabitTracker
//
//  Created by Arnaldo Baumanis on 9/26/25.
//

import SwiftUI

/*
 Creates a calendar view where each day of the month is represented by a circle. Different colors
 indicate whether a habit was completed on that day and other conditions related to the habit schedule. The
 demo mode (isDemo) decides how some parts are displayed initially, like weekday labels.
 */
struct HabitCalendarView: View {
    var isDemo: Bool = false
    var createdAt: Date
    var frequencies: [HabitFrequency]
    var completeDates: [TimeInterval]
    
    var body: some View {
        /*
         This establishes the layout for the calendar view. A LazyVGrid is
         used, which means the grid will dynamically adjust its contents
         as needed.
         */
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 12) {
            if !isDemo {
                ForEach(HabitFrequency.allCases, id: \.rawValue) { frequency in
                    Text(frequency.rawValue.prefix(3))
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
            
            ForEach(0..<Date.startOffsetOfThisMonth, id: \.self) {_ in
                Circle()
                    .fill(.clear)
                    .frame(height: 30)
                    .hSpacing(.center)
            }
            
            ForEach(Date.datesInThisMonth, id: \.self) { date in
                let day = date.format("dd")
                
                Text(day)
                    .font(.caption)
                    .frame(height: 30)
                    .hSpacing(.center)
                    .background {
                        let isHabitCompleted = completeDates.contains { $0 == date.timeIntervalSince1970 }
                        let isHabitDay = frequencies.contains {
                            $0.rawValue == date.weekDay
                        } && date.startOfDay >= createdAt.startOfDay
                        let isFutureHabits = date.startOfDay > Date()
                        
                        if isHabitCompleted && isHabitDay && !isDemo {
                            Circle()
                                .fill(.blue.tertiary)
                        } else if isHabitDay && !isFutureHabits && !isDemo {
                            Circle()
                                .fill((date.isToday ? Color.yellow : Color.red).tertiary)
                        } else {
                            if isHabitDay {
                                Circle()
                                    .fill(.fill)
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    HabitCalendarView(createdAt: .now, frequencies: [.sunday, .tuesday, .saturday], completeDates: [])
}
