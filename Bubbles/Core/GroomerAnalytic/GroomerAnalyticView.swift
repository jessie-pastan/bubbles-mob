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
            Text("Booking analytic")
            Button {
                Task{
                    try await viewModel.uploadSevendayBookingData()
                    try await viewModel.fetchSevendayBookingData()
                }
            } label: {
                //fetch 7 days booking data
                Text("Weekly booking ")
            }
            
        }
    }
}

struct GroomerAnalyticView_Previews: PreviewProvider {
    static var previews: some View {
        GroomerAnalyticView()
    }
}
