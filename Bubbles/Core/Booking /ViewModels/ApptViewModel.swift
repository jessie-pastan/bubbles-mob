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
    
    init() {
        Task{
           
        }
    }
}
