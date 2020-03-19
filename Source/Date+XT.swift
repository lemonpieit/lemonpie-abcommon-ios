//
//  Date+XT.swift
//  BikeApp
//
//  Created by Francesco Colleoni on 24/01/17.
//  Copyright © 2017 Mindtek srl. All rights reserved.
//

import Foundation

public extension Date {
    
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
    
    // MARK: - From String to Date
    /// Convert from String to a Date object.
    /// - Parameters:
    ///   - string: The string representation of a date.
    ///   - format: The desired format of the returned date.
    static func from(string: String, withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: string)
    }
    
    // MARK: - From Date to formatted String
    /// Convert from Date to a String.
    /// - Parameters:
    ///   - format: The desired format of the returned date.
    func formatted(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    /// Convert from Date to a String with the current receiver Locale.
    /// - Parameters:
    ///   - format: The desired format of the returned date.
    func formattedWithCurrentLocale(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    /// Returns the  day of the week of a given date in full.
    func dayInWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"//"EE" to get short style
        return dateFormatter.string(from: self)
    }
    
    /// Returns the month name of a given date.
    func getMonthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"//"LL" to get short style
        return dateFormatter.string(from: self)
    }
    
    // MARK: - From Date to String
    /// Returns a given date with the specified styles.
    /// - Parameter style: The style of the time.
    /// - Returns: Wednesday, March 18, 2020
    ///
    /// Full: Wednesday, March 18, 2020
    ///
    /// Long: March 18, 2020
    ///
    /// Medium: Mar 18, 2020
    ///
    /// Short: 3/18/20
    func localizedString(dateWithStyle style: DateFormatter.Style) -> String {
        return localizedString(withDateStyle: style, timeStyle: .none)
    }
    
    /// Returns a given time with the specified styles.
    /// - Parameter style: The style of the date.
    /// - Returns: 5:25:01 PM Central European Standard Time
    ///
    /// Full: 5:25:01 PM Central European Standard Time
    ///
    /// Long: 5:33:35 PM GMT+1
    ///
    /// Medium: 5:33:35 PM
    ///
    /// Short: 5:33 PM
    func localizedString(timeWithStyle style: DateFormatter.Style) -> String {
        return localizedString(withDateStyle: .none, timeStyle: style)
    }
    
    /// Returns a given date and time with the specified styles.
    /// - Parameters:
    ///   - dateStyle: The style of the date.
    ///   - timeStyle: The style of the time.
    /// - Returns: Wednesday, March 18, 2020 at 5:25:01 PM Central European Standard Time
    ///
    /// Full: Wednesday, March 18, 2020 at 5:25:01 PM Central European Standard Time
    ///
    /// Long: March 18, 2020 at 5:33:35 PM GMT+1
    ///
    /// Medium: Mar 18, 2020 at 5:33:35 PM
    ///
    /// Short: 3/18/20, 5:33 PM
    func localizedString(withDateStyle dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        
        return dateFormatter.string(from: self)
    }
    
    /// Adds the parameters components to the given date.
    /// - Parameters:
    ///   - seconds: The seconds component.
    ///   - minutes: The minutes component.
    ///   - hours: The hours component.
    ///   - days: The days component.
    ///   - years: The years component.
    func adding(seconds: Int, minutes: Int = 0, hours: Int = 0, days: Int = 0, years: Int = 0) -> Date {
        var timeInterval = Double(seconds)
        timeInterval += 60 * Double(minutes)
        timeInterval += 60 * 60 * Double(hours)
        timeInterval += 24 * 60 * 60 * Double(days)
        timeInterval += 24 * 60 * 60 * 365 * Double(years)

        return addingTimeInterval(timeInterval)
    }
    
    /// Removes the parameters components from the given date.
    /// - Parameters:
    ///   - seconds: The seconds component.
    ///   - minutes: The minutes component.
    ///   - hours: The hours component.
    ///   - days: The days component.
    ///   - years: The years component.
    func removing(seconds: Int, minutes: Int = 0, hours: Int = 0, days: Int = 0, years: Int = 0) -> Date {
        var timeInterval = Double(seconds)
        
        timeInterval -= 60 * Double(minutes)
        timeInterval -= 60 * 60 * Double(hours)
        timeInterval -= 24 * 60 * 60 * Double(days)
        timeInterval -= 24 * 60 * 60 * 365 * Double(years)
        
        return addingTimeInterval(timeInterval)
    }
    
    /// Returns multiple components of a given date.
    /// - Parameters:
    ///   - calendarUnits: The various components of a calendar date.
    /// - Returns: 18
    ///
    /// Days: 18
    ///
    /// Month: 3
    ///
    /// Year: 202
    func components(_ calendarUnits: [Calendar.Component]) -> [Calendar.Component: Int] {
        var result: [Calendar.Component: Int] = [:]
            for unit in calendarUnits {
                result[unit] = component(unit)
        }
        return result
    }
    
    /// Returns one component of a given date.
    /// - Parameters:
    ///   - calendarUnits: The various components of a calendar date.
    /// - Returns: 18
    ///
    /// Days: 18
    ///
    /// Month: 3
    ///
    /// Year: 202

    func component(_ calendarUnit: Calendar.Component) -> Int {
        return Calendar.current.component(calendarUnit, from: self)
    }
    
    /// Returns a date created from the specified components.
    /// - Parameters:
    ///   - calendar: The user's calendar.
    ///   - units: Calendar components units.
    ///   - timeZone: The user's time zone.
    static func with(calendar: Calendar = .current, units: [Calendar.Component: Int], timeZone: TimeZone = Calendar.current.timeZone) -> Date? {
        let dateComponents = DateComponents(calendar: calendar,
                                            timeZone: timeZone,
                                            era: units[.era],
                                            year: units[.year],
                                            month: units[.month],
                                            day: units[.day],
                                            hour: units[.hour],
                                            minute: units[.minute],
                                            second: units[.second],
                                            nanosecond: units[.nanosecond],
                                            weekday: units[.weekday],
                                            weekdayOrdinal: units[.weekdayOrdinal],
                                            quarter: units[.quarter],
                                            weekOfMonth: units[.weekOfMonth],
                                            weekOfYear: units[.weekOfYear],
                                            yearForWeekOfYear: units[.yearForWeekOfYear])
        return Calendar.current.date(from: dateComponents)
    }
    
    /// Combines a given date with the time of another give date.
    /// - Parameters:
    ///   - date: The date to combine.
    ///   - time: The time to combine.
    func combineDateWithTime(date: Date?, time: Date?) -> Date? {
        guard let date = date, let time = time else {
            return nil
        }
        
        let calendar = NSCalendar.current
        
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)
        
        var mergedComponments = DateComponents()
        mergedComponments.year = dateComponents.year!
        mergedComponments.month = dateComponents.month!
        mergedComponments.day = dateComponents.day!
        mergedComponments.hour = timeComponents.hour!
        mergedComponments.minute = timeComponents.minute!
        mergedComponments.second = timeComponents.second!
        
        return calendar.date(from: mergedComponments)
    }
    
    /// Returns the beginning of the next hour of a given date.
    func nextHourDate() -> Date? {
        let calendar = Calendar.current
        var comps = calendar.dateComponents([.era, .year, .day, .hour], from: self)
        
        repeat {
            guard let date = comps.day, let hour = comps.hour else {
                return nil
            }
            var newHour = hour + 1
            
            if newHour > 23 {
                newHour = 0
                let newDay = date + 1
                comps.day = newDay
            }
            comps.hour = newHour
        } while comps.hour! % 3 != 0
        
        let newMinute = 0
        comps.minute = newMinute
        
        guard let newDate =  calendar.date(from: comps) else {
            return nil
        }
        return newDate
    }
    
    func rounded(minutes: TimeInterval, rounding: DateRoundingType = .round) -> Date {
        return rounded(seconds: minutes * 60, rounding: rounding)
    }
    
    func rounded(seconds: TimeInterval, rounding: DateRoundingType = .round) -> Date {
        var roundedInterval: TimeInterval = 0
        switch rounding {
        case .round:
            roundedInterval = (timeIntervalSinceReferenceDate / seconds).rounded() * seconds
        case .ceil:
            roundedInterval = ceil(timeIntervalSinceReferenceDate / seconds) * seconds
        case .floor:
            roundedInterval = floor(timeIntervalSinceReferenceDate / seconds) * seconds
        }
        return Date(timeIntervalSinceReferenceDate: roundedInterval)
    }
}

public extension Calendar.Component {
    func value(fromDate date: Date) -> Int {
        return date.component(self)
    }
}

public enum DateRoundingType {
    case round
    case ceil
    case floor
}
