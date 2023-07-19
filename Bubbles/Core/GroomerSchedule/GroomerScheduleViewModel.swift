//
//  GroomerScheduleViewModel.swift
//  Bubbles
//
//  Created by Jessie P on 7/16/23.
//

import Foundation
import FirebaseAuth
import Firebase
class GroomerScheduleViewModel: ObservableObject {
   
    
    //Current week days
    @Published var currentWeek = [Date]()
    
    // current Day
    @Published var currentDay: Date = Date()
    
    // filter today's schedule for groomer( current User )
    @Published var todayGroomerSchedules: [Schedule]?
    
    
    
    init(){
        fetchCurrentWeek()
        Task{
            try await fetchTodaySchedules()
        }
       
        
    }
    
    func fetchTodaySchedules() async throws {
        //guard let currentUserId =  Auth.auth().currentUser?.uid else { return }
        //let snapshot = try await Firestore.firestore().collection("schedules").getDocuments()
    }
    
    func fetchCurrentWeek() {
        
        let today = Date()
        //create calender
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        guard let firstWeekDay  = week?.start else {return}
        
        (1...7).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekday)
            }
        }
    }
    
    //this func is return MON, TUE, WED etc. display in UI
    func extractDate(date: Date, format: String)-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    //this func checking if current Date is Today
    func isToday(date: Date)-> Bool {
        
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
}
