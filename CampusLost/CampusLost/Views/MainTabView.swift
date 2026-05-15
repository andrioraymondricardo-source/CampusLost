//
//  MainTabView.swift
//  CampusLost
//
//  Created by Andrio Raymond Ricardo on 6/5/2026.
//

import SwiftUI

//This is a way to link all three main views with a tab style like in modern apps.
struct MainTabView: View {
   
    var body: some View {

        TabView {

            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            AddReportView()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Add")
                }

            MapView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                }
        }
        .tint(AppTheme.primary)
    }
}

#Preview {
    MainTabView()
}
