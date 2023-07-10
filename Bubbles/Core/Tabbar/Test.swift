//
//  Test.swift
//  Bubbles
//
//  Created by Jessie P on 7/9/23.
//

import SwiftUI

struct Test: View {
   
    var body: some View {
           NavigationView {
               VStack {
                   NavigationLink(destination: IntermediateView1()) {
                       Text("Go to Intermediate View 1")
                   }
               }
               .navigationBarTitle("Root View")
           }
       }
   }

   struct IntermediateView1: View {
       @Environment(\.presentationMode) var presentationMode
       
       var body: some View {
           VStack {
               Text("Intermediate View 1")
               
               NavigationLink(destination: IntermediateView2()) {
                   Text("Go to Intermediate View 2")
               }
           }
           .navigationBarTitle("Intermediate 1")
       }
   }

struct IntermediateView2: View {
    
    @State var isActive = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
        
             
           
        }
    }
}

   struct IntermediateView3: View {
       @Environment(\.presentationMode) var presentationMode
       
       var body: some View {
           VStack {
               Text("Intermediate View 3")
               
               Button(action: {
                   self.presentationMode.wrappedValue.dismiss()
                   self.presentationMode.wrappedValue.dismiss()
                   self.presentationMode.wrappedValue.dismiss()
                   
                   
               }) {
                   Text("Back to Root")
               }
           }
           .navigationBarTitle("Intermediate 3")
       }

}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
