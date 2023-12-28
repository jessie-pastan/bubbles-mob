//
//  Test.swift
//  Bubbles
//
//  Created by Jessie P on 7/9/23.
//

/*
import SwiftUI
import Foundation
import Firebase
import FirebaseAuth

struct TimeSlotsView: View {
    
    @StateObject var timeSlots = TimeSlotsViewModel()
    
    @State private var selectedTimeSlot: Date = Date()
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        VStack(alignment: .leading){
        
            HStack{
                Text("Select Date")
                    .font(.callout)
                    .bold()
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.automatic)
            }
            .padding(.horizontal,40)
            
            HStack{
                Text("Selected Time Slot: ")
                    .padding()
                Spacer()
                Picker("Select a time slot", selection: $selectedTimeSlot) {
                    Text("Select")
                    ForEach(timeSlots.timeSlots, id: \.self) { timeSlot in
                        Text(timeSlots.formatTimeSlot(timeSlot))
                    }
                }
                .pickerStyle(.automatic)
                .padding(.horizontal,40)
            }
            
        }
        
    }
}

struct TimeSlotsView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSlotsView()
    }
}



@MainActor
class TimeSlotsViewModel: ObservableObject {
    
    @Published var timeSlots = [Date]()
   
    
    init() {
        self.timeSlots = generateTimeSlots()
        
    }
    
    func generateTimeSlots() -> [Date] {
        let calendar = Calendar.current
        let startDate = calendar.date(bySettingHour: 10, minute: 0, second: 0, of: Date())!
        let endDate = calendar.date(bySettingHour: 15, minute: 0, second: 0, of: Date())!
        
        var timeSlots: [Date] = []
        var currentSlot = startDate
        
        while currentSlot <= endDate {
            timeSlots.append(currentSlot)
            currentSlot = calendar.date(byAdding: .hour, value: 1, to: currentSlot)!
        }
        
        return timeSlots
    }
    
    func formatTimeSlot(_ timeSlot: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: timeSlot)
    }
    
  
    
    
}
*/
