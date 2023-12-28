//
//  GroomerScheduleView.swift
//  Bubbles
//
//  Created by Jessie P on 7/16/23.
//

import SwiftUI

struct GroomerScheduleView: View {
    @StateObject var viewModel = GroomerScheduleViewModel()
    @Namespace var animetion
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            //LAZY STACK WITH PINNED HEADER
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]){
                Section {
                   
                    // CURRENT WEEK VIEW
                    // display all schedule current groomer has
                    ScrollView(.horizontal, showsIndicators: false)  {
                        HStack(spacing: 10){
                            ForEach(viewModel.currentWeek, id: \.self) { day in
                                VStack{
                                    Text(viewModel.extractDate(date: day, format: "dd"))
                                        .font(.system(size: 16))
                                        .fontWeight(.semibold)
                                    //extract first 3 letters of each day to display
                                    Text(viewModel.extractDate(date: day, format: "EEE"))
                                        .font(.system(size: 14))
                                        .fontWeight(.semibold)
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 8, height: 8)
                                        .opacity(viewModel.isToday(date: day) ? 1 : 0)
                                }
                                
                                //capsule shape
                                .foregroundColor(viewModel.isToday(date: day) ? .white : .black)
                                .frame(width: 45, height: 90)
                                .background(
                                    // match geomaetry effect
                                    ZStack{
                                        if viewModel.isToday(date: day) {
                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "currentday", in: animetion)
                                        }
                                    }
                                )
                                // make it animate when user tap
                                .contentShape(Capsule())
                                .onTapGesture {
                                    //update current day
                                    withAnimation {
                                        viewModel.currentDay = day 
                                    }
                                }
                            }
                        }.padding(.horizontal)
                    }
                } header: {
                    HeaderView()
                    
                }
                
            }
            
        }
    }
    
    //Header
    func HeaderView()-> some View {
        HStack{
            VStack(alignment: .leading, spacing: 10){
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .foregroundColor(.gray)
                Text("Today")
                    .font(.largeTitle.bold())
                
            }
            //extension function
            .hLeading()
            
            
            Button {
                //
            } label: {
                Image("shop12")
                    .resizable()
                    .aspectRatio( contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            }

        }
        .padding()
        .background(Color(.white))
        
    }
    
}

struct GroomerScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        GroomerScheduleView()
    }
}

//UI design helper function
extension View {
    func hLeading()->some View{
        self
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    func hTrailing()->some View{
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
        
    }
    
    func hCenter()->some View{
        self
            .frame(maxWidth: .infinity, alignment: .center)
        
    }
    
    
}
