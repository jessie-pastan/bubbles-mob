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
                   VStack(alignment: .leading){
                       Text("Total").bold().font(.title2)
                       Text("Compensate").foregroundColor(.gray).font(.caption).opacity(0.5)
                       
                   }
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
                   VStack(alignment: .leading){
                       Text("Weekly").bold().font(.title2)
                       Text("Compensate(last 7 days)").foregroundColor(.gray).font(.caption).opacity(0.5)
                       
                   }
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
                 VStack(alignment: .leading){
                     Text("Today's").bold().font(.title)
                     Text("Compensate").foregroundColor(.gray).font(.caption).opacity(0.5)
                 }
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

        Spacer()
            //MARK: Compensate in detail
            if !viewModel.sortedIncomes.isEmpty {
            
                VStack(alignment: .center){
                    Text("Compensate in detail").bold()
                    ScrollView {
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
                .background(Color(.systemBackground).clipShape(RoundedRectangle(cornerRadius: 20)))
                .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
            }else{
                Text("No recent income")
                    .bold()
                    .frame( maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
            }
            
            
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
