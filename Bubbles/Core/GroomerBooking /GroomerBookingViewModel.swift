//
//  GroomerBookingViewModel.swift
//  Bubbles
//
//  Created by Jessie P on 7/27/23.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

@MainActor
class GroomerBookingViewModel : ObservableObject {
    @Published var date = Date()
    @Published var appts = [Appointment]()
    @Published var sortedAppts = [Appointment]()
    

    
    func fetchTodayBookings(date: Date) async throws {
        guard let uid = AuthService.shared.currentUser?.id else { return }
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        let snapshots = try await Firestore.firestore().collection("appointments").whereField("groomerId", isEqualTo: uid).whereField("dueDate", isGreaterThanOrEqualTo: startOfDay).whereField("dueDate", isLessThan: endOfDay).getDocuments()
        self.appts = snapshots.documents.compactMap({try? $0.data(as: Appointment.self)})
        sortedTime(appts: self.appts)
    }
    
    func sortedTime(appts: [Appointment]){
        self.sortedAppts = SortedTime.clockwiseSortedItems(appts: appts)
    }
    
    func updateDone(item : Appointment) async throws {
        var copyItem = item
        copyItem.setDone()
        // update done appt in firebase
        try Firestore.firestore().collection("appointments").document(copyItem.id ?? "").setData(from:copyItem)
    }
}
