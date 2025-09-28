//
//  HabitCardView.swift
//  HabitTracker
//
//  Created by Arnaldo Baumanis on 9/26/25.
//

import SwiftUI

struct HabitCardView: View {
    // This property holds an identifier used to manage animations during transitions.
    var animationID: Namespace.ID
    // An instance of the Habit model representing the current habit being displayed.
    var habit: Habit
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(habit.name)
                        .font(.callout)
                    Text("Created at " + habit.createdAt.format("dd MM, YYYY"))
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }
                Spacer(minLength: 0)
                
                CompletionProgressIndicator()
            }
            
            HabitCalendarView(
                createdAt: habit.createdAt,
                frequencies: habit.frequencies,
                completeDates: habit.completedDates
            )
            .applyPaddedBackground(10)
            .matchedTransitionSource(id: habit.uniqueID, in: animationID)
            
            if habit.frequencies.contains(where: { $0.rawValue == Date.now.weekDay }) && !habit.completedDates.contains(Date.now.startOfDay.timeIntervalSince1970) {
                CompleteButton()
            }
        }
    }
    
    @ViewBuilder
    func CompleteButton() -> some View {
        VStack(spacing: 10) {
            Text("Complete Habit?")
                .font(.callout)
            HStack(spacing: 10) {
                Button("Yes, complete!") {
                    withAnimation(.snappy) {
                        let todayTimeStamp = Date.now.startOfDay.timeIntervalSince1970
                        habit.completedDates.append(todayTimeStamp)
                    }
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 10))
                .tint(.green)
            }
        }
        .hSpacing(.center)
        .applyPaddedBackground(10)
    }
    
    @ViewBuilder
    func CompletionProgressIndicator() -> some View {
        let habitMatchingDatesInThisMonth = Date.datesInThisMonth.filter { date in
            habit.frequencies.contains {
                $0.rawValue == date.weekDay
            } && date.startOfDay >= habit.createdAt.startOfDay
        }
        
        let habitsCompletedInThisMonth = habitMatchingDatesInThisMonth.filter {
            habit.completedDates.contains($0.timeIntervalSince1970)
        }
        
        let progress = CGFloat(habitsCompletedInThisMonth.count) / CGFloat(habitMatchingDatesInThisMonth.count)
        
        VStack(spacing: 6) {
            ZStack {
                Circle()
                    .stroke(.fill, lineWidth: 3)
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(.blue.gradient, lineWidth: 3)
                    .rotationEffect(.init(degrees: -90))
            }
            .frame(width: 30, height: 30)
            
            Text("\(habitsCompletedInThisMonth.count)/\(habitMatchingDatesInThisMonth.count)")
                .font(.caption2)
                .foregroundStyle(.gray)
        }
    }
}
