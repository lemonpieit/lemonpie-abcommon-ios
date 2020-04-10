//
//  EventsCalendarManager.swift
//  CustomerArea
//
//  Created by Luigi Aiello on 03/03/2020.
//  Copyright © 2020 ABenergie S.p.A. All rights reserved.
//

import UIKit
import EventKit
import EventKitUI

public struct Event {
    
    var name: String?
    var startDate: Date?
    var endDate: Date?
    
    public init(name: String?, startDate: Date?, endDate: Date?) {
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
    }
}

public enum CustomError: String, Error {
    case eventAlreadyExistsInCalendar
    case eventNotAddedToCalendar
    case calendarAccessDeniedOrRestricted
    case unknown
}

public typealias EventsCalendarManagerResponse = (_ result: Result<Bool, CustomError>) -> Void

public class EventsCalendarManager: NSObject {

    var eventStore = EKEventStore()
    
    // Request access to the Calendar
    private func requestAccess(completion: @escaping EKEventStoreRequestAccessCompletionHandler) {
        eventStore.requestAccess(to: EKEntityType.event) { (accessGranted, error) in
            completion(accessGranted, error)
        }
    }
    
    // Get Calendar auth status
    private func getAuthorizationStatus() -> EKAuthorizationStatus {
        return EKEventStore.authorizationStatus(for: .event)
    }
    
    // MARK: - Custom UI
    // Try to add an event to the calendar if authorized
    public func addEventToCalendar(event: Event, completion: @escaping EventsCalendarManagerResponse) {
        let authStatus = getAuthorizationStatus()
        
        switch authStatus {
        case .authorized:
            // Try to add the event
            self.addEvent(event: event) { (result) in
                switch result {
                case .success:
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        case .notDetermined:
            //Auth is not determined
            //We should request access to the calendar
            requestAccess { (accessGranted, error) in
                if accessGranted {
                    self.addEvent(event: event) { (result) in
                        switch result {
                        case .success:
                            completion(.success(true))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                } else {
                    // Auth denied, we should display a popup
                    completion(.failure(.calendarAccessDeniedOrRestricted))
                }
            }
        case .denied, .restricted:
            // Auth denied or restricted, we should display a popup
            completion(.failure(.calendarAccessDeniedOrRestricted))
        default:
            // Unknown Error
            completion(.failure(.unknown))
        }
    }
    
    private func addEvent(event: Event, completion: @escaping EventsCalendarManagerResponse) {
        let eventToAdd = generateEvent(event: event)
        
        if !eventAlreadyExists(event: eventToAdd) {
            do {
                try eventStore.save(eventToAdd, span: .thisEvent)
                completion(.success(true))
            } catch {
                // Error while trying to create event in calendar
                completion(.failure(.eventNotAddedToCalendar))
            }
        } else {
            completion(.failure(.eventAlreadyExistsInCalendar))
        }
    }
    
    // Generate an event which will be then added to the calendar
    private func generateEvent(event: Event) -> EKEvent {
        let newEvent = EKEvent(eventStore: eventStore)
        newEvent.calendar = eventStore.defaultCalendarForNewEvents
        newEvent.title = event.name
        newEvent.startDate = event.startDate
        newEvent.endDate = event.endDate
         
        let inOneYear =  Date() + TimeInterval(24 * 60 * 60 * 365)
//        let rule = EKRecurrenceRule(recurrenceWith: .daily, interval: 10, end: .init(end: Date().adding(seconds: 0, minutes: 0, hours: 0, days: 0, years: 1)))
        let rulee = EKRecurrenceRule(recurrenceWith: .monthly, interval: 1, daysOfTheWeek: nil, daysOfTheMonth: [-3],
                                     monthsOfTheYear: nil, weeksOfTheYear: nil, daysOfTheYear: nil, setPositions: nil, end: .init(end: inOneYear))
        
        newEvent.recurrenceRules = [rulee]
        
        // Set default alarm minutes before event
//        let alarm = EKAlarm(relativeOffset: TimeInterval(Configuration.addEventToCalendarAlarmMinutesBefore()*60))
//        newEvent.addAlarm(alarm)
        return newEvent
    }
    
    // Check if the event was already added to the calendar
    private func eventAlreadyExists(event eventToAdd: EKEvent) -> Bool {
        let predicate = eventStore.predicateForEvents(withStart: eventToAdd.startDate, end: eventToAdd.endDate, calendars: nil)
        let existingEvents = eventStore.events(matching: predicate)
    
        let eventAlreadyExists = existingEvents.contains { (event) -> Bool in
            return eventToAdd.title == event.title && event.startDate == eventToAdd.startDate && event.endDate == eventToAdd.endDate
        }
        
        return eventAlreadyExists
    }

    // MARK: - Kit UI
    // Show event kit ui to add event to calendar
    public func presentCalendarModalToAddEvent(event: Event, completion : @escaping EventsCalendarManagerResponse) {
        let authStatus = getAuthorizationStatus()
        switch authStatus {
        case .authorized:
            presentEventCalendarDetailModal(event: event)
            completion(.success(true))
        case .notDetermined:
            //Auth is not determined
            //We should request access to the calendar
            requestAccess { (accessGranted, error) in
                if accessGranted {
                    self.presentEventCalendarDetailModal(event: event)
                    completion(.success(true))
                } else {
                    // Auth denied, we should display a popup
                    completion(.failure(.calendarAccessDeniedOrRestricted))
                }
            }
        case .denied, .restricted:
            // Auth denied or restricted, we should display a popup
            completion(.failure(.calendarAccessDeniedOrRestricted))
        default:
            // Unknown Error
            completion(.failure(.unknown))
        }
    }

    // Present edit event calendar modal
    public func presentEventCalendarDetailModal(event: Event) {
        let event = generateEvent(event: event)
        let eventModalVC = EKEventEditViewController()
        eventModalVC.event = event
        eventModalVC.eventStore = eventStore
        eventModalVC.editViewDelegate = self
        
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            rootVC.present(eventModalVC, animated: true, completion: nil)
        }
    }
}

// EKEventEditViewDelegate
extension EventsCalendarManager: EKEventEditViewDelegate {
    public func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
}
