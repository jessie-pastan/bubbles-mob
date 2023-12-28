//
//  Router.swift
//  Bubbles
//
//  Created by Jessie P on 8/19/23.
//

import Foundation
import SwiftUI
// don't delete
class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    func backToRoot() {
        path = NavigationPath()
    }
     
    func edit() {
       
    }
}
