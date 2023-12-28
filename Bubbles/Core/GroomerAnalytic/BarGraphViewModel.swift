//
//  BarGraphViewModel.swift
//  Bubbles
//
//  Created by Jessie P on 8/9/23.
//

import Foundation
class BarGraphViewModel: GroomerAnalyticViewModel {
    
    // Getting Max CGFloat from [BookingData]
    func getMax(bookingData: [BookingData])->CGFloat{
        let max = bookingData.max { first, scnd in
            return scnd.bookings > first.bookings
        }?.bookings ?? 0
        return max
    }
    
    // getting Sample Graph Lines based on max Value...
    func getGraphLines(bookingData : [BookingData])->[CGFloat]{
        
        let max = getMax(bookingData: bookingData)
        
        var lines: [CGFloat] = []
        
        lines.append(max)
        
        for index in 1...3{
            
            // dividing the max by 4 and iterating as index for graph lines...
            let progress = max / 3
            
            lines.append(max - (progress * CGFloat(index)))
        }
        
        return lines
    }
    
    
    func getBarHeight(point: CGFloat, size: CGSize, bookingData : [BookingData]) -> CGFloat{
        
        let max = getMax(bookingData: bookingData)
        
        // 25 Text Height
        // 5 Spacing..
        let height = (point / max) * (size.height - 37)
        
        return height
    }
    
}
