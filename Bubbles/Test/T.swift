//
//  T.swift
//  Bubbles
//
//  Created by Jessie P on 8/21/23.
//

import SwiftUI

import SwiftUI

struct T: View {
    @State private var tabBarHidden = false
    @State private var scrollPosition: CGFloat = 0
    
    var body: some View {
        TabView {
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(1..<50) { index in
                            Text("Item \(index)")
                                .frame(height: 100)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        }
                    }
                    .onChange(of: scrollPosition) { newPosition in
                        tabBarHidden = newPosition > scrollPosition
                    }
                    .onAppear {
                        scrollViewProxy.scrollTo(0)
                    }
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                        scrollPosition = value
                    }
                }
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("List")
            }
            
            Text("Another Tab")
                .tabItem {
                    Image(systemName: "star")
                    Text("Star")
                }
        }
        .overlayPreferenceValue(ScrollOffsetPreferenceKey.self) { value in
            Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: value)
        }
        .onChange(of: tabBarHidden) { hidden in
            withAnimation {
                tabBarHidden = hidden
            }
        }
        .overlayPreferenceValue(TabBarHiddenPreferenceKey.self) { value in
            GeometryReader { geometry in
                if tabBarHidden {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: geometry.safeAreaInsets.bottom)
                        .preference(key: TabBarHiddenPreferenceKey.self, value: true)
                }
            }
        }
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct TabBarHiddenPreferenceKey: PreferenceKey {
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = value || nextValue()
    }
}


struct T_Previews: PreviewProvider {
    static var previews: some View {
        T()
    }
}
