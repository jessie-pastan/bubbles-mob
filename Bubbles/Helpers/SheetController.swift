//
//  SheetController.swift
//  Bubbles
//
//  Created by Jessie P on 7/31/23.
//

import Foundation
class SheetController: ObservableObject {
    @Published var isShowingNoteSheet = false
    @Published var isShowingEditNoteSheet = false

     func showNoteSheet() {
        isShowingNoteSheet = true
    }

    func showEditNoteSheet() {
        isShowingEditNoteSheet = true
    }

    func dismissAllSheets() {
        isShowingEditNoteSheet = false
        // try to create smooth transition between view
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.isShowingNoteSheet = false
                }
        
        
    }
}





