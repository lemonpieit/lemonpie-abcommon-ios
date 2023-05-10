//
//  DateComponents+XT.swift
//  ABcommon
//
//  Created by Francesco Leoni on 29/10/2020.
//

import Foundation

internal extension DateComponents {
  static let allComponents: [Calendar.Component] = [.nanosecond, .second, .minute, .hour,
                                                    .day, .month, .year, .yearForWeekOfYear,
                                                    .weekOfYear, .weekday, .quarter, .weekdayOrdinal,
                                                    .weekOfMonth]
}
