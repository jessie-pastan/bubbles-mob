//
//  GroomerCompensateView.swift
//  Bubbles
//
//  Created by Jessie P on 8/4/23.
//

import SwiftUI

struct GroomerCompensateView: View {
    
    @ObservedObject var viewModel = GroomerCompensateViewModel()
    
    var body: some View {
        VStack {
           HStack(){
               //MARK: Total Compensate
               // totalPrice  of every appt. done since start working

               VStack{
                   Text("Total").bold().font(.title2)
                   Text("Compensate").foregroundColor(.gray)
                   Text("$ \(viewModel.allCompensate)")
                       .frame(width: getRect().width / 4.5)
                       .cornerRadius(15)
       
               }
                       .padding(.horizontal,30)
                       .padding(.vertical)
                       .background(Color.white)
                       .cornerRadius(25)
                       // shadows..
                       .shadow(color: Color.black.opacity(0.1), radius: 10, x: 10, y: 0)
               
        
               //MARK: Weekly Compensate
               VStack{
                   // totalPrice  of appt. done during that week
                        Text("Weekly").bold().font(.title2)
                        Text("Compensate(last 7 days)").foregroundColor(.gray)
                        Text(" $\(viewModel.sevendayCompensate)")
                       .frame(width: getRect().width / 4.5)
                       .cornerRadius(15)
                   
               }
               .padding(.horizontal,30)
               .padding(.vertical)
               .background(Color.white)
               .cornerRadius(25)
               // shadows..
               .shadow(color: Color.black.opacity(0.1), radius: 10, x: 10, y: 0)
                
            }
            
            //MARK: Today's Compensate
             // totalPrice  of appt. done today
             VStack{
                 Text("Today's").bold().font(.title)
                 Text("Compensate").foregroundColor(.gray)
                 Text("$ \(viewModel.todayCompensate)")
                     .frame(width: getRect().width / 4.5)
                     .cornerRadius(15)
     
             }
                     .padding(.horizontal,30)
                     .padding(.vertical)
                     .background(Color.white)
                     .cornerRadius(25)
                     // shadows..
                     .shadow(color: Color.black.opacity(0.1), radius: 10, x: 10, y: 0)

               

            Divider()
            
            VStack(alignment: .leading){
                Text("Compensate in detail").bold()
                List{
                    ForEach(viewModel.sortedIncomes) { groomerIncome in
                        if groomerIncome.income != 0 {
                            HStack{
                                Text("Date: \(groomerIncome.apptDate.formatted(date: .abbreviated, time: .omitted))  ")
                                    .bold()
                                Text("Income: $\(groomerIncome.income)")
                            }
                        }
                    }
                }
            }
            .padding()
            
        }.onAppear {
            Task{
                try await viewModel.fetchTodayIncome()
                try await viewModel.fetchLastSevendayIncome()
                try await viewModel.fetchAllincome()
            }
        }
    }
}

struct GroomerCompensateView_Previews: PreviewProvider {
    static var previews: some View {
        GroomerCompensateView()
    }
}
