//
//  BarGraphView.swift
//  Bubbles
//
//  Created by Jessie P on 8/9/23.
//

import SwiftUI

struct BarGraphView: View {
    @ObservedObject var viewModel =  GroomerAnalyticViewModel()
    var bookings : [BookingData]
    var body: some View {
        VStack(spacing: 20){
            
            HStack{
                
                Text("Booking Analytic")
                    .fontWeight(.bold)
                
                Spacer()
                
                Menu {
                    
                    Button("Month"){}
                    Button("Year"){}
                    Button("Week"){}
                    
                } label: {
                    HStack(spacing: 4){
                        
                        Text("this week")
                        
                        Image(systemName: "arrowtriangle.down.fill")
                            .scaleEffect(0.7)
                    }
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
                }

            }
            
            HStack(spacing: 10){
                
                Capsule()
                    .fill(Color(.systemCyan))
                    .frame(width: 20, height: 8)
                
                Text("Bookings")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
            // Graph View
            GraphView(bookings: bookings)
                .padding(.top,20)
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.top,25)
    }
}


