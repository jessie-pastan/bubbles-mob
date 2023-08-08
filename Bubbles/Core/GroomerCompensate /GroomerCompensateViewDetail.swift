//
//  GroomerCompensateViewDetail.swift
//  Bubbles
//
//  Created by Jessie P on 8/6/23.
//

import Foundation
import Firebase

@MainActor
class GroomerCompensateViewDetail : ObservableObject {
    @Published var todayCompensate: Int = 0
    @Published var sevendayCompensate: Int = 0
    @Published var allCompensate: Int = 0
    @Published var sevenDayschedules = [Schedule]()
    @Published var sortedSchedules = [Schedule]()
    @Published var allSchedule = [Schedule]()
    @Published var sortedIncomes = [GroomerIncomeData]()
    @Published var sevendayIncome = [GroomerIncomeData]()
    
    
    func fetchTodayIncome() async throws {
        let currentDate = Date()
        guard let uid = AuthService.shared.currentUser?.id else { return }
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: currentDate)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        //fetch a selected schedule
        let snapshots =  try await Firestore.firestore().collection("groomerIncomeData").whereField("groomerId", isEqualTo: uid).whereField("apptDate", isGreaterThanOrEqualTo: startOfDay).whereField("apptDate", isLessThan: endOfDay).getDocuments()
        let incomes = snapshots.documents.compactMap { (try? $0.data(as: GroomerIncomeData.self)) }
        self.todayCompensate = incomes.reduce(0, {$0 + ($1.income)})
    }
    
    func fetchAllincome() async throws  {
        //let today = Date()
        guard let uid = AuthService.shared.currentUser?.id else { return }
        
        //fetch all schedule from start until today
       
        let snapshots =  try await Firestore.firestore().collection("groomerIncomeData").whereField("groomerId", isEqualTo: uid).getDocuments()
        
        let allIncomes = snapshots.documents.compactMap { (try? $0.data(as: GroomerIncomeData.self)) }
        print("DEBUG : all income[] : \(allIncomes)")
        self.sortedIncomes = SortedTime.sortedByDate(incomes: allIncomes)
        self.allCompensate = allIncomes.reduce(0, {$0 + ($1.income)})
        print("all compensate: \(self.allCompensate)")
    }
    
    func fetchLastSevendayIncome() async throws {
        let currentDate = Date()
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: currentDate)!
        guard let uid = AuthService.shared.currentUser?.id else { return }
        //fetch 7 days schedule
        let snapshots =  try await Firestore.firestore().collection("groomerIncomeData").whereField("groomerId", isEqualTo: uid).whereField("apptDate", isGreaterThan: sevenDaysAgo ).getDocuments()
        self.sevendayIncome = snapshots.documents.compactMap { (try? $0.data(as: GroomerIncomeData.self)) }
        print("7daysIncome : \(self.sevendayIncome)")
        self.sevendayCompensate =  self.sevendayIncome.reduce(0, {$0 + ($1.income)})
        print("7day Com : \(self.sevendayCompensate)")
    }
    
    
    
    
    
    /*
    
    func fetchTodayCompensate() async throws  {
        let currentDate = Date()
        guard let uid = AuthService.shared.currentUser?.id else { return }
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: currentDate)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        //fetch a selected schedule
        let snapshots =  try await Firestore.firestore().collection("users").document(uid).collection("schedules").whereField("date", isGreaterThanOrEqualTo: startOfDay).whereField("date", isLessThan: endOfDay).getDocuments()
        let schedules = snapshots.documents.compactMap { (try? $0.data(as: Schedule.self)) }
        guard let schedule = schedules.first else { return }
        print("Today Compensate :\(schedule.compensate)")
        self.todayCompensate = schedule.compensate
    }
    
    
    
    func fetchLastSevendayCompensate() async throws {
        let currentDate = Date()
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: currentDate)!
        guard let uid = AuthService.shared.currentUser?.id else { return }
        //fetch 7 days schedule
        let snapshots =  try await Firestore.firestore().collection("users").document(uid).collection("schedules").whereField("date", isGreaterThan: sevenDaysAgo ).getDocuments()
        self.sevenDayschedules = snapshots.documents.compactMap { (try? $0.data(as: Schedule.self)) }
        print("7daysSchedule : \(self.sevenDayschedules)")
        self.sevendayCompensate =  self.sevenDayschedules.reduce(0, {$0 + ($1.compensate)})
        print("7day Com : \(self.sevendayCompensate)")
    }
    
    
    func fetchAllCompensate() async throws  {
        //let today = Date()
        guard let uid = AuthService.shared.currentUser?.id else { return }
        //fetch all schedule from start until today
        
        
        let snapshots =  try await Firestore.firestore().collection("users").document(uid).collection("schedules").getDocuments()
        self.allSchedule = snapshots.documents.compactMap { (try? $0.data(as: Schedule.self)) }
        print("all schedules: \(self.allSchedule)")
        print("all sched count: \(self.allSchedule.count)")
        self.sortedSchedules = SortedTime.sortedByDate(schedule: self.allSchedule)
        self.allCompensate = self.allSchedule.reduce(0, {$0 + ($1.compensate)})
        print("all compensate: \(self.allCompensate)")
    }
     
    
    */
    
    
}
