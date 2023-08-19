//
//  FetchSchedule.swift
//  Bubbles
//
//  Created by Jessie P on 7/21/23.
//
/*
import SwiftUI
import Firebase

struct ScheduleListView: View {
    @State var schedules = [Schedule]()
    @State var targetSchedule = [Schedule]()
    let userId =
    "by8y259Vt3goFrRVNYFv3bqsfYC2" // Pass the userId to the view
    let date = Date()
    var body: some View {
        /*
        List(schedules) { schedule in
            Text("\(schedule.date)")
            ForEach(schedule.timeSlots) { timeSlot in
             
                    Text("\(timeSlot.timeString)")
                    Text("\(timeSlot.id)")
                    Text(String("IsBooked: \(timeSlot.isBooked)"))
                
            }
         */
        
        List(targetSchedule) { schedule in
            Text("\(schedule.date.formatted(date: .abbreviated, time: .omitted))")
            Text(String("isFullbooked: \(schedule.isFullBooked)"))
            ForEach(schedule.timeSlots) { timeSlot in
                
                Text("\(timeSlot.timeString)")
                //Text("\(timeSlot.id)")
                Text(String("IsBooked: \(timeSlot.isBooked)"))
            }
            
        }
        .onAppear {
            Task{
                //self.schedules = try await queryGroomerSchedule(groomerId: userId)
                targetSchedule = try await queryScheduleByselectDate(groomerId: userId, selectDate: date)
            }
        }
    }

    func queryGroomerSchedule(groomerId: String) async throws -> [Schedule] {
        
        
        var schedules = [Schedule]()
       
        // Fetch schedule documents for the groomer
        let snapshot = try await Firestore.firestore().collection("users").document(groomerId).collection("schedules").getDocuments()
        let documents = snapshot.documents
        
        for doc in documents {
            let schedule = try doc.data(as:Schedule.self)
            schedules.append(schedule)
        }
        
        return schedules
    }
    
    
    func queryScheduleByselectDate(groomerId: String, selectDate: Date) async throws -> [Schedule] {
        //var targetSchedule = try Schedule(from: Schedule.MOCK_selectedDateAndTime as! Decoder)
        var targetSchedule = [Schedule]()
        let schedules = try await queryGroomerSchedule(groomerId: groomerId)
        for schedule in schedules {
            let groomerDateString = (schedule.date.formatted(date: .abbreviated, time: .omitted))
            let selectDateString = selectDate.formatted(date: .abbreviated, time: .omitted)
            if groomerDateString == selectDateString {
                targetSchedule.append(schedule)
            }
           
        }
        
        return targetSchedule
        
    }
}
struct ScheduleListView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleListView()
    }
}
*/
