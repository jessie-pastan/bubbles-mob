//
//  SortedTime .swift
//  Bubbles
//
//  Created by Jessie P on 7/27/23.
//

import Foundation
class SortedTime {
    static func clockwiseSortedItems(appts: [Appointment]) -> [Appointment] {
        return appts.sorted { item1, item2 in
            return item1.timeDate < item2.timeDate
        }
    }
    
    
    static func sortedItemsByDayAndTime(appts: [Appointment]) -> [Appointment] {
        return appts.sorted { item1, item2 in
            let calendar = Calendar.current

            // Extract components for item1
            let day1 = calendar.component(.day, from: item1.dueDate)
            let hour1 = calendar.component(.hour, from: item1.timeDate)
            let minute1 = calendar.component(.minute, from: item1.timeDate)

            // Extract components for item2
            let day2 = calendar.component(.day, from: item2.dueDate)
            let hour2 = calendar.component(.hour, from: item2.timeDate)
            let minute2 = calendar.component(.minute, from: item2.timeDate)

            // Compare days
            if day1 != day2 {
                return day1 < day2
            } else {
                // If the days are the same, compare times
                if hour1 != hour2 {
                    return hour1 < hour2
                } else {
                    return minute1 < minute2
                }
            }
        }
    }
    
    //showing income from recent > past 
    static func sortedByDate(incomes: [GroomerIncomeData]) -> [GroomerIncomeData] {
        return incomes.sorted { $0.apptDate > $1.apptDate}
        }
    
    
    
    
    
    
    
    
}
