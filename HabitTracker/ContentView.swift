//
//  ContentView.swift
//  HabitTracker
//
//  Created by Arnaldo Baumanis on 9/25/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isIntroComplete") private var isIntroComplete: Bool = false
    
    var body: some View {
        ZStack {
            if isIntroComplete {
                NavigationStack {
                    HomeView()
                }
                .transition(.move(edge: .trailing))
            } else {
                NavigationStack {
                    IntroPageView()
                }
                .transition(.move(edge: .leading))
            }
        }
        .animation(.snappy(duration: 0.25, extraBounce: 0), value: isIntroComplete)
    }
}

#Preview {
    ContentView()
}
