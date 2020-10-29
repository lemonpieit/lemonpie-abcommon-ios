//
//  Int+XT.swift
//  ABcommon
//
//  Created by Francesco Leoni on 29/10/2020.
//

import Foundation

/// This allows us to transform a literal number in a `DateComponents` and use it in math operations
/// For example `5.days` will create a new `DateComponents` where `.day = 5`.
public extension Int {
  /// Internal transformation function.
  ///
  /// - parameter type: component to use.
  ///
  /// - returns: return self value in form of `DateComponents` where given `Calendar.Component` has `self` as value.
  internal func toDateComponents(type: Calendar.Component) -> DateComponents {
    var dateComponents = DateComponents()
    DateComponents.allComponents.forEach { dateComponents.setValue(0, for: $0) }
    dateComponents.setValue(self, for: type)
    dateComponents.setValue(0, for: .era)
    return dateComponents
  }

  /// Create a `DateComponents` with `self` value set as nanoseconds.
  var nanosecondsComponent: DateComponents {
    return toDateComponents(type: .nanosecond)
  }

  /// Create a `DateComponents` with `self` value set as seconds.
  var secondsComponent: DateComponents {
    return toDateComponents(type: .second)
  }

  /// Create a `DateComponents` with `self` value set as minutes.
  var minutesComponent: DateComponents {
    return toDateComponents(type: .minute)
  }

  /// Create a `DateComponents` with `self` value set as hours.
  var hoursComponent: DateComponents {
    return toDateComponents(type: .hour)
  }

  /// Create a `DateComponents` with `self` value set as days.
  var daysComponent: DateComponents {
    return toDateComponents(type: .day)
  }

  /// Create a `DateComponents` with `self` value set as weeks.
  var weeksComponent: DateComponents {
    return toDateComponents(type: .weekOfYear)
  }

  /// Create a `DateComponents` with `self` value set as months.
  var monthsComponent: DateComponents {
    return toDateComponents(type: .month)
  }

  /// Create a `DateComponents` with `self` value set as years.
  var yearsComponent: DateComponents {
    return toDateComponents(type: .year)
  }

  /// Create a `DateComponents` with `self` value set as quarters.
  var quartersComponent: DateComponents {
    return toDateComponents(type: .quarter)
  }
}

public extension Int {
  /// Create a `TimeInterval` with `self` value set as seconds.
  var seconds: TimeInterval {
    return TimeInterval(self)
  }

  /// Create a `TimeInterval` with `self` value set as minutes.
  var minutes: TimeInterval {
    return TimeInterval(self) * 60.seconds
  }

  /// Create a `TimeInterval` with `self` value set as hours.
  var hours: TimeInterval {
    return TimeInterval(self) * 60.minutes
  }

  /// Create a `TimeInterval` with `self` value set as days.
  var days: TimeInterval {
    return TimeInterval(self) * 24.hours
  }

  /// Create a `TimeInterval` with `self` value set as weeks.
  var weeks: TimeInterval {
    return TimeInterval(self) * 7.days
  }
}
