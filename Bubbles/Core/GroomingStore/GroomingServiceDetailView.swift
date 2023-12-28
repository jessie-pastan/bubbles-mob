//
//  GroomingServiceDetailView.swift
//  Bubbles
//
//  Created by Jessie P on 7/12/23.
//

import SwiftUI

struct GroomingServiceDetailView: View {
    
        var service: GroomingService
        
        var body: some View {
            VStack{
                Text(service.item)
            }
    }
}

struct GroomingServiceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GroomingServiceDetailView(service: GroomingService.MOCK_GROOMIMGSERVICE[0])
    }
}
