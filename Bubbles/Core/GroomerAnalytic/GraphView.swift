//
//  GraphView.swift
//  Bubbles
//
//  Created by Jessie P on 8/9/23.
//

import SwiftUI

struct GraphView: View {
    @ObservedObject var viewModel = BarGraphViewModel()
    var bookings: [BookingData]
    var body: some View {
        
        GeometryReader{proxy in
            
            ZStack{
                
                VStack(spacing: 0){
                    
                    ForEach(viewModel.getGraphLines(bookingData: bookings),id: \.self){line in
                        
                        HStack(spacing: 8){
                            
                            Text("\(Int(line))")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .frame(height: 20)
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 1)
                        }
                        .frame(maxHeight: .infinity,alignment: .bottom)
                        // Removing the text size...
                        .offset(y: -15)
                    }
                }
                
                HStack{
                    ForEach(bookings) { data in
                        
                        VStack(spacing: 0){
                            
                            VStack(spacing: 5){
                                
                                Capsule()
                                    .fill(Color(.systemCyan))
                                
                               
                            }
                            .frame(width: 8)
                            .frame(height: viewModel.getBarHeight(point: data.bookings, size: proxy.size, bookingData: bookings))
                            
                            Text(data.day.rawValue)
                                .font(.caption)
                                .frame(height: 25,alignment: .bottom)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    }
                }
                .padding(.leading,30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        // Fixed Height
        .frame(height: 190)
    }
    
}


