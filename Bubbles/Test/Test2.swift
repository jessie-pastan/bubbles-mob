//
//  Test2.swift
//  Bubbles
//
//  Created by Jessie P on 7/10/23.
//

import SwiftUI

struct Test2: View {
    @Environment(\.presentationMode) var mode
    var body: some View {
        
        Text("Completed Booking")
        Button("Back to HomePage") {
            mode.wrappedValue.dismiss()
        }
    }
}

struct Test2_Previews: PreviewProvider {
    static var previews: some View {
        Test2()
    }
}
