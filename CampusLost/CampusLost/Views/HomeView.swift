//
//  HomeView.swift
//  CampusLost
//
//  Created by Andrio Raymond Ricardo on 6/5/2026.
//

import SwiftUI

struct SampleItem: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let type: String
    let category: String
    let location: String
    let description: String
    let contact: String
}

struct HomeView: View {

    @StateObject private var filterViewModel = ItemFilterViewModel()
    @State private var searchText = ""
    @State private var selectedTypeFilter = "All"
    @State private var selectedCategoryFilter = "All"

    let items = [
        SampleItem(
            icon: "headphones",
            title: "AirPods Pro",
            type: "Lost",
            category: "Electronics",
            location: "UTS Library",
            description: "White AirPods Pro case lost near the study area around 2PM.",
            contact: "andrio@student.uts.edu.au"
        ),
        SampleItem(
            icon: "wallet.pass",
            title: "Student ID Card",
            type: "Found",
            category: "Cards",
            location: "Building 10",
            description: "Found student ID card near the entrance of Building 10.",
            contact: "campuslost@student.uts.edu.au"
        ),
        SampleItem(
            icon: "key.fill",
            title: "Apartment Keys",
            type: "Lost",
            category: "Keys",
            location: "Building 1",
            description: "Lost a small key set with a black keychain.",
            contact: "student@example.com"
        )
    ]

    var filteredItems: [SampleItem] {
        items.filter { item in
            let matchesStatus =
            selectedTypeFilter == "All" || item.type == selectedTypeFilter
            
            let matchesCategory =
            selectedCategoryFilter == "All" || item.category == selectedCategoryFilter

            let matchesSearch =
            searchText.isEmpty ||
            item.title.localizedCaseInsensitiveContains(searchText) ||
            item.category.localizedCaseInsensitiveContains(searchText) ||
            item.location.localizedCaseInsensitiveContains(searchText)

            return matchesStatus && matchesSearch && matchesCategory
        }
    }

    var body: some View {

        NavigationStack {

            ZStack {

                LinearGradient(
                    colors: [
                        AppTheme.primary.opacity(0.15),
                        AppTheme.background
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                ScrollView {

                    VStack(alignment: .leading, spacing: 20) {

                        VStack(alignment: .leading, spacing: 8) {
                            Text("CampusLost")
                                .font(.largeTitle)
                                .fontWeight(.bold)

                            Text("Find and report lost or found items around campus.")
                                .foregroundStyle(.secondary)
                        }

                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.secondary)

                            TextField("Search items", text: $searchText)
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(AppTheme.cornerRadius)

                        HStack(spacing: 12) {
                            Text("Status:")
                            FilterTypeButton(title: "All", selectedTypeFilter: $selectedTypeFilter)
                            ForEach(ReportType.allCases){reportType in
                                    FilterTypeButton(title: reportType.rawValue, selectedTypeFilter: $selectedTypeFilter)
                            }
                        }
                        
                        HStack{
                            Text("Category:")
                            ScrollView(.horizontal, showsIndicators: false)
                            {
                                HStack(spacing: 12) {
                                    FilterCategoryButton(title: "All", selectedCategoryFilter: $selectedCategoryFilter)
                                    ForEach(ItemCategory.allCases){reportType in
                                        FilterCategoryButton(title: reportType.rawValue, selectedCategoryFilter: $selectedCategoryFilter)
                                    }
                                }
                            }
                        }

                        VStack(spacing: 16) {
                            ForEach(filteredItems) { item in
                                NavigationLink {
                                    ItemDetailView(item: item)
                                } label: {
                                    ItemRowView(
                                        icon: item.icon,
                                        title: item.title,
                                        subtitle: "\(item.type) • \(item.category)",
                                        location: item.location
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct FilterTypeButton: View {

    let title: String
    @Binding var selectedTypeFilter: String

    var body: some View {
        Button {
            selectedTypeFilter = title
        } label: {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    selectedTypeFilter == title
                    ? AppTheme.primary
                    : AppTheme.primary.opacity(0.15)
                )
                .foregroundStyle(
                    selectedTypeFilter == title
                    ? .white
                    : AppTheme.primary
                )
                .cornerRadius(30)
        }
    }
}

struct FilterCategoryButton: View {

    let title: String
    @Binding var selectedCategoryFilter: String

    var body: some View {
        Button {
            selectedCategoryFilter = title
        } label: {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    selectedCategoryFilter == title
                    ? AppTheme.primary
                    : AppTheme.primary.opacity(0.15)
                )
                .foregroundStyle(
                    selectedCategoryFilter == title
                    ? .white
                    : AppTheme.primary
                )
                .cornerRadius(30)
        }
    }
}

#Preview {
    HomeView()
}
