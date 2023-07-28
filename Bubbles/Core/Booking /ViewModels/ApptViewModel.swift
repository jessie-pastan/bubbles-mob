//
//  ApptViewModel.swift
//  Bubbles
//
//  Created by Jessie P on 7/26/23.
//

import Foundation
import FirebaseAuth

@MainActor
class ApptViewModel : ObservableObject {
    @Published var appts = [Appointment]()
    @Published var sortedAppts = [Appointment]()
    
    func fetchAppt() async throws {
        self.appts = try await UserService.fetchUserAppts()
        self.sortedAppts = SortedTime.sortedItemsByDayAndTime(appts: appts)
        
    }
    
    
}
