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
        //MainTabView is only accessible when the user has pick out a university for the session.
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
