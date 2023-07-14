//
//  TestViewModel.swift
//  Bubbles
//
//  Created by Jessie P on 7/12/23.
//

import Foundation
import SwiftUI

class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    func backToRoot() {
        path = NavigationPath()
    }
     
    func edit() {
       
    }
}
