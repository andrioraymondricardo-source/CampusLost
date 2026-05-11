//
//  ContentView.swift
//  CampusLost
//
//  Created by Hyeok In on 5/5/2026.
//

import SwiftUI

struct ContentView: View {

    @AppStorage("selectedUniversity") private var selectedUniversity: String = ""
    @State private var hasSelectedSessionUniversity = false

    var body: some View {
        if !hasSelectedSessionUniversity {
            OnBoardingView(hasSelectedSessionUniversity: $hasSelectedSessionUniversity)
        } else {
            MainTabView()
        }
    }
}

#Preview {
    ContentView()
}
