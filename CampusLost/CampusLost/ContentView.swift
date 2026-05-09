//
//  ContentView.swift
//  CampusLost
//
//  Created by Hyeok In on 5/5/2026.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedUniversity") private var selectedUniversity: String = ""

    var body: some View {
        if selectedUniversity.isEmpty {
            OnBoardingView()
        } else {
            MainTabView()
        }
    }
}

#Preview {
    ContentView()
}
