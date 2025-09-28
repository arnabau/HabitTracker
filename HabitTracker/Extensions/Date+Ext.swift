//
//  Date+Ext.swift
//  HabitTracker
//
//  Created by Arnaldo Baumanis on 9/26/25.
//

import SwiftUI


extension Date {
    /*
     Returns the day of the week as a string.
     It uses the current calendar's weekdaySymbols array to get the appropriate symbol based on the day of the
     week, then subtracts 1 because the component(.weekday, from:) function in Swift Calendar API starts
     counting days from Sunday (0) with an array index starting at 1.
     */
    var weekDay: String {
        let calendar = Calendar.current
        let weekDay  = calendar.weekdaySymbols[calendar.component(.weekday, from: self) - 1]
        return weekDay
    }
    
    /*
     Returns a new date representing the start of the day (midnight) for the given date.
     */
    var startOfDay: Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: self)
    }
    
    /*
     This method checks if the current date is today's date.
     */
    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    
    /*
     Formats a date according to a specified string format (like yyyy-MM-dd or MM/dd/yyyy).
     */
    func format(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    static var startOffsetOfThisMonth: Int {
        Calendar.current.component(.weekday, from: startDateOfThisMonth)
    }
    
    static var startDateOfThisMonth: Date {
        let calendar = Calendar.current
        guard let date = calendar.date(from: calendar.dateComponents([.year, .month], from: .now)) else {
            fatalError("Cannot retrieve date")
        }
        
        return date
    }
    
    static var datesInThisMonth: [Date] {
        let calendar = Calendar.current
        guard let range = calendar.range(of: .day, in: .month, for: .now) else {
            fatalError("Cannot retrieve date")
        }
        
        return range.compactMap {
            calendar.date(byAdding: .day, value: $0 - 1, to: .startDateOfThisMonth)
        }
    }
}
