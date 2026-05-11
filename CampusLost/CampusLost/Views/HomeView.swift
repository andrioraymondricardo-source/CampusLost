//
//  HomeView.swift
//  CampusLost
//
//  Created by Andrio Raymond Ricardo on 6/5/2026.
//

import SwiftUI

//struct SampleItem: Identifiable {
//    let id = UUID()
//    let icon: String
//    let title: String
//    let type: String
//    let category: String
//    let location: String
//    let description: String
//    let contact: String
//}

struct HomeView: View {
    
    @Binding var selectedTab: AppTab

    @StateObject private var filterViewModel = ItemFilterViewModel()
    
    @AppStorage("selectedUniversity") private var selectedUniversityRawData = University.uts.rawValue
    
    private var selectedUniversity: University {
        University(rawValue: selectedUniversityRawData) ?? .uts
    }
    
    private var filteredItems: [LostFoundItem] {
        filterViewModel.filter(selectedUniversity: selectedUniversity)
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

                            TextField("Search items", text: $filterViewModel.searchText)
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(AppTheme.cornerRadius)

                        HStack(spacing: 12) {
                            Text("Status:")
                            Button {
                                   filterViewModel.selectedReportType = nil
                               } label: {
                                   Text("All")
                                       .font(.subheadline)
                                       .fontWeight(.semibold)
                                       .padding(.horizontal, 16)
                                       .padding(.vertical, 10)
                                       .background(
                                           filterViewModel.selectedReportType == nil
                                           ? AppTheme.primary
                                           : AppTheme.primary.opacity(0.15)
                                       )
                                       .foregroundStyle(
                                           filterViewModel.selectedReportType == nil
                                           ? .white
                                           : AppTheme.primary
                                       )
                                       .cornerRadius(30)
                               }

                               ForEach(ReportType.allCases, id: \.self) { reportType in
                                   Button {
                                       filterViewModel.selectedReportType = reportType
                                   } label: {
                                       Text(reportType.rawValue)
                                           .font(.subheadline)
                                           .fontWeight(.semibold)
                                           .padding(.horizontal, 16)
                                           .padding(.vertical, 10)
                                           .background(
                                               filterViewModel.selectedReportType == reportType
                                               ? AppTheme.primary
                                               : AppTheme.primary.opacity(0.15)
                                           )
                                           .foregroundStyle(
                                               filterViewModel.selectedReportType == reportType
                                               ? .white
                                               : AppTheme.primary
                                           )
                                           .cornerRadius(30)
                                   }
                               }
                        }
                        
                        HStack{
                            Text("Category:")
                            ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 12) {
                                        Button {
                                            filterViewModel.selectedCategory = nil
                                        } label: {
                                            Text("All")
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                                .padding(.horizontal, 16)
                                                .padding(.vertical, 10)
                                                .background(
                                                    filterViewModel.selectedCategory == nil
                                                    ? AppTheme.primary
                                                    : AppTheme.primary.opacity(0.15)
                                                )
                                                .foregroundStyle(
                                                    filterViewModel.selectedCategory == nil
                                                    ? .white
                                                    : AppTheme.primary
                                                )
                                                .cornerRadius(30)
                                        }

                                        ForEach(ItemCategory.allCases, id: \.self) { category in
                                            Button {
                                                filterViewModel.selectedCategory = category
                                            } label: {
                                                Text(category.rawValue)
                                                    .font(.subheadline)
                                                    .fontWeight(.semibold)
                                                    .padding(.horizontal, 16)
                                                    .padding(.vertical, 10)
                                                    .background(
                                                        filterViewModel.selectedCategory == category
                                                        ? AppTheme.primary
                                                        : AppTheme.primary.opacity(0.15)
                                                    )
                                                    .foregroundStyle(
                                                        filterViewModel.selectedCategory == category
                                                        ? .white
                                                        : AppTheme.primary
                                                    )
                                                    .cornerRadius(30)
                                            }
                                        }
                                    }
                                }
                        }

                        VStack(spacing: 16) {
                            
                            if filteredItems.isEmpty {
                                Text("No reports found.")
                                    .foregroundStyle(.secondary)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(.white)
                                    .cornerRadius(AppTheme.cornerRadius)
                            } else {
                                ForEach(filteredItems, id: \.id) { item in
                                    NavigationLink {
                                        ItemDetailView(item: item)
                                    } label: {
                                        ItemRowView(
                                            icon: item.category.iconName,
                                            title: item.title,
                                            subtitle: "\(item.reportType.rawValue) • \(item.category.rawValue)",
                                            location: item.locationName
                                        )
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            filterViewModel.loadItems()
        }
    }
}


#Preview {
    HomeView(selectedTab: .constant(.home))
}
