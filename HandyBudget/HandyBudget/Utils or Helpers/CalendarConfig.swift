//
//  CalendarConfig.swift
//  HandyBudget
//
//  Created by Jadson on 25/11/2025.
//
import Foundation

enum BaselineCycle: String, CaseIterable {
    case weekly = "Weekly"
    case fortnightly = "Fortnightly"
    case monthly = "Monthly"
    
    var cycleDay: Int{
        switch self {
            case .weekly: return 6
            case .fortnightly: return 13
            case .monthly: return -1 // check how to handle this case
        }
    }
}

enum Weekday: Int, CaseIterable {
    case sun = 1, mon, tue, wed, thu, fri, sat
    
    func endCycle(for cycle: BaselineCycle) -> Weekday {
        let daysToAdd = cycle.cycleDay
        let adjusted = ((self.rawValue - 1 + daysToAdd) % 7) + 1
        return Weekday(rawValue: adjusted)!
    }
//    
//    var endCycle: Weekday {
//        switch self {
//            case .sun:
//                return .sat
//            case .mon:
//                return .tue
//            case .tue:
//                return .mon
//            case .wed:
//                return .tue
//            case .thu:
//                return .wed
//            case .fri:
//                return .thu
//            case .sat:
//                return .fri
//        }
//    }
    
    var weekdaySymbol: String {
        let position = self.rawValue - 1
        return Calendar.with(language: "en-NZ").weekdaySymbols[position]
    }
    
    var shortWeekdaySymbol: String {
        let position = self.rawValue - 1
        return Calendar.with(language: "en-NZ").shortWeekdaySymbols[position]
    }
}

//MARK: - Calendar Locale Helper

extension Calendar {
    static func with(language: String?) -> Calendar {
        var calendar = Calendar.current
        if let language {
            calendar.locale = .init(identifier: language)
        }
        return calendar
    }
}

//MARK: - Baseline Calculator

struct BaselineCalculator {
    // Returns the last day of a monthly cycle
    static func endDayOfMonth(startDay: Int) -> Int {
        // Simple rule: cycle ends the day BEFORE the next cycle start
        return startDay == 1 ? 30 : startDay - 1
    }
    
    /// Main function to compute the end of cycle as text for UI
    static func endCycleDescription(
        baseline: BaselineCycle,
        startWeekday: Weekday? = nil,
        startDay: Int? = nil
    ) -> String {
        
        switch baseline {
            case .weekly, .fortnightly:
                guard let start = startWeekday else {
                    return "Select a weekday"
                }
                
                let end = start.endCycle(for: baseline)
                return "Your \(baseline.rawValue) baseline cycle starts on \(start.weekdaySymbol) and ends on \(end.weekdaySymbol)."
                
            case .monthly:
                guard let startDay else {
                    return "Select a day"
                }
                
                let endDay = endDayOfMonth(startDay: startDay)
                return "Your baseline cycle is monthly starting on day \(startDay) and ends on day \(endDay)."
        }
    }
}
