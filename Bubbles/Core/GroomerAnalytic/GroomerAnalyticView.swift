//
//  GroomerAnalyticView.swift
//  Bubbles
//
//  Created by Jessie P on 8/8/23.
//

import SwiftUI

struct GroomerAnalyticView: View {
    @ObservedObject var viewModel = GroomerAnalyticViewModel()
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 18){
                    
                    // Graph View....
                    BarGraphView(bookings: viewModel.sevendayBookingData)
                    
                    // Users View...
                    HStack(spacing: 0){
                        
                        // Progress View...
                        UserProgress(title: "New Clients", color: Color(.systemCyan), image: "person", progress: 38)
                        
                        UserProgress(title: "Return Clients", color: Color(.systemMint), image: "person", progress: 62)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(18)
                    
                    // Most Downloads...
                    VStack{
                        
                        HStack{
                            
                            Text("Most Booking Service")
                                .font(.callout.bold())
                            
                            Spacer()
                            
                            Menu {
                                
                                Button("More"){}
                                Button("Extra"){}
                                
                            } label: {
                                
                                Image("menu")
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(.primary)
                            }
                        }
                        
                        HStack(spacing: 15){
                            
                            Image(systemName: "scissors.circle.fill")
                                .resizable()
                                .rotationEffect(.degrees(-90))                                .frame(width: 40, height: 40)
                                .font(.title2)
                                .foregroundColor(.black)
                                .padding(12)
                                .background(
                                    
                                    Color.gray
                                        .opacity(0.25)
                                        .clipShape(Circle())
                                )
                            
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Text("Full Grooming")
                                    .fontWeight(.bold)
                                
                                Text("389 Bookings")
                                    .font(.caption2.bold())
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                       
                        .padding(.top,20)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(18)
                }
                .padding()
            }
        }.onAppear {
            Task{
                try await viewModel.uploadSevendayBookingData()
                try await viewModel.fetchSevendayBookingData()
            }
        }
    }
        
        @ViewBuilder
        func UserProgress(title: String,color: Color,image: String,progress: CGFloat)->some View{
            
            HStack{
                
                Image(systemName: "person")
                    .font(.title2)
                    .foregroundColor(Color(.blue))
                    .padding(10)
                    .background(
                    
                        ZStack{
                            
                            Circle()
                                .stroke(Color.gray.opacity(0.3),lineWidth: 2)
                            
                            Circle()
                                .trim(from: 0, to: progress / 100)
                                .stroke(color,lineWidth: 2)
                                .rotationEffect(.init(degrees: -90))
                        }
                    )
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("\(Int(progress))%")
                        .fontWeight(.bold)
                    
                    Text(title)
                        .font(.caption2.bold())
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity,alignment: .leading)
        }
    
            
}
    
struct GroomerAnalyticView_Previews: PreviewProvider {
    static var previews: some View {
        GroomerAnalyticView()
    }
}
