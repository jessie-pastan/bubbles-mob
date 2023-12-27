//
//  ConvertTime.swift
//  Bubbles
//
//  Created by Jessie P on 7/26/23.
//

import Foundation
class ConvertTime {
    
    static func switchTimeFormatted(timeString: String) -> String {
            
        switch timeString {
        case "10 AM" :
            return "10.00.00"
        case "11 AM" :
            return "11.00.00"
        case "12 PM" :
            return "12.00.00"
        case "1 PM" :
            return "13.00.00"
        case "2 PM" :
            return "14.00.00"
        default:
            return ""
        }
    }
    
    
    static func convertTimeStringToTimeOnly(timeString: String) -> Date? {
        let time = switchTimeFormatted(timeString: timeString)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        return dateFormatter.date(from: time)
    }
    
    
}
    
    
    
    //for testing
    /*let timeString = "15:30:00"
    if let timeOnly = timeSlots.convertTimeStringToTimeOnly(timeString: timeString) {
        Text("\(timeOnly)")
    } else {
        //print("Failed to convert the time string to Time.")
    }
     */
    
     

