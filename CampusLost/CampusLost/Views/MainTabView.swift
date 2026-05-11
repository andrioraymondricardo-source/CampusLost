//
//  MainTabView.swift
//  CampusLost
//
//  Created by Andrio Raymond Ricardo on 6/5/2026.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedTab: AppTab = .home
   
    var body: some View {

        TabView {

            HomeView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(AppTab.home)

            AddReportView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Add")
                }
                .tag (AppTab.add)

            MapView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                }
                .tag(AppTab.map)
        }
        .tint(AppTheme.primary)
    }
}

enum AppTab{
    case home
    case map
    case add
}

#Preview {
    MainTabView()
}
