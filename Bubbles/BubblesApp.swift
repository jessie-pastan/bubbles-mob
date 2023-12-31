//
//  BubblesApp.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct BubblesApp: App {
    // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AddPetViewModel())
                .environmentObject(BookingViewModel())
                .environmentObject(Router())
                .environmentObject(ApptViewModel())
            
        }
    }
}
