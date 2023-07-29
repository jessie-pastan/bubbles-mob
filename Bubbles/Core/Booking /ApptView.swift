//
//  ApptView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseAuth

struct ApptView: View {
    
    @StateObject var viewModel = ApptViewModel()
    
    var body: some View {
        
        Text("heloo")
    }
}

struct ApptView_Previews: PreviewProvider {
    static var previews: some View {
        ApptView(user: User.MOCK_USERS[0])
    }
}
