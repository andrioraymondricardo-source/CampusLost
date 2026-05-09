//
//  HomeView.swift
//  CampusLost
//
//  Created by Andrio Raymond Ricardo on 6/5/2026.
//

import SwiftUI
import SwiftData

struct HomeView: View {

    // gets all saved items from SwiftData
    @Query private var items: [LostFoundItem]

    @State private var searchText = ""

    @State private var selectedFilter = "All"

    // filtered items based on tab and search
    var filteredItems: [LostFoundItem] {

        items.filter { item in

            let matchesFilter: Bool

            if selectedFilter == "All" {

                matchesFilter = item.status == .active

            } else if selectedFilter == "Lost" {

                matchesFilter =
                item.reportType == .lost &&
                item.status == .active

            } else if selectedFilter == "Found" {

                matchesFilter =
                item.reportType == .found &&
                item.status == .active

            } else if selectedFilter == "Resolved" {

                matchesFilter =
                item.status == .resolved

            } else {

                matchesFilter = true
            }

            let matchesSearch =

            searchText.isEmpty ||

            item.title.localizedCaseInsensitiveContains(searchText) ||

            item.locationName.localizedCaseInsensitiveContains(searchText)

            return matchesFilter && matchesSearch
        }
    }

    var body: some View {

        NavigationStack {

            ZStack {

                // background gradient
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

                        // page title
                        VStack(alignment: .leading, spacing: 8) {

                            Text("CampusLost")
                                .font(.largeTitle)
                                .fontWeight(.bold)

                            Text("Find and report lost or found items around campus.")
                                .foregroundStyle(.secondary)
                        }

                        // search bar
                        HStack {

                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.secondary)

                            TextField("Search items", text: $searchText)
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(AppTheme.cornerRadius)

                        // filter buttons
                        ScrollView(.horizontal, showsIndicators: false) {

                            HStack(spacing: 12) {

                                FilterButton(
                                    title: "All",
                                    selectedFilter: $selectedFilter
                                )

                                FilterButton(
                                    title: "Lost",
                                    selectedFilter: $selectedFilter
                                )

                                FilterButton(
                                    title: "Found",
                                    selectedFilter: $selectedFilter
                                )

                                FilterButton(
                                    title: "Resolved",
                                    selectedFilter: $selectedFilter
                                )
                            }
                        }

                        // empty state
                        if filteredItems.isEmpty {

                            EmptyStateView()

                        } else {

                            VStack(spacing: 16) {

                                ForEach(filteredItems) { item in

                                    NavigationLink {

                                        ItemDetailView(item: item)

                                    } label: {

                                        ItemRowView(
                                            icon: iconForCategory(item.category),
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
    }

    // converts category enum into SF Symbol icon
    func iconForCategory(_ category: ItemCategory) -> String {

        switch category {

        case .electronics:
            return "headphones"

        case .cards:
            return "wallet.pass"

        case .clothing:
            return "tshirt"

        case .books:
            return "book.closed"

        case .bottles:
            return "waterbottle"

        case .keys:
            return "key.fill"

        case .bags:
            return "bag.fill"

        case .other:
            return "questionmark.circle"
        }
    }
}

// reusable filter button
struct FilterButton: View {

    let title: String

    @Binding var selectedFilter: String

    var body: some View {

        Button {

            selectedFilter = title

        } label: {

            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    selectedFilter == title
                    ? AppTheme.primary
                    : AppTheme.primary.opacity(0.15)
                )
                .foregroundStyle(
                    selectedFilter == title
                    ? .white
                    : AppTheme.primary
                )
                .cornerRadius(30)
        }
        .animation(.smooth, value: selectedFilter)
    }
}

// empty search/filter result state
struct EmptyStateView: View {

    var body: some View {

        VStack(spacing: 12) {

            Image(systemName: "magnifyingglass")
                .font(.system(size: 42))
                .foregroundStyle(.secondary)

            Text("No items found")
                .font(.headline)

            Text("Try another keyword or change the filter.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 80)
    }
}

#Preview {

    HomeView()
}
