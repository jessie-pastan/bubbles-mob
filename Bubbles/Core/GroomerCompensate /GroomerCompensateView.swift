//
//  GroomerCompensateView.swift
//  Bubbles
//
//  Created by Jessie P on 8/4/23.
//

import SwiftUI

struct GroomerCompensateView: View {
    
    @ObservedObject var viewModel = GroomerCompensateViewDetail()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                // totalPrice  of appt. done today
                Text("Today's compensate: $\(viewModel.todayCompensate) " )
                
                // totalPrice  of appt. done during that week
                Text("Weekly Compensate(last 7 days): $\(viewModel.sevendayCompensate)")
                
                // totalPrice  of every appt. done since start working
                Text("Total Compensate: $\(viewModel.allCompensate)")
            }
            Divider()
            
            Text("Compensate in detail")
            ScrollView{
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
