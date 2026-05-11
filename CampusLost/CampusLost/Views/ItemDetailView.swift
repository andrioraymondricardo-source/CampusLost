//
//  ItemDetailView.swift
//  CampusLost
//
//  Created by Andrio Raymond Ricardo on 6/5/2026.
//

import SwiftUI
import SwiftData

struct ItemDetailView: View {

    // allows this view to update the selected report status
    @Environment(\.modelContext) private var modelContext

    let item: LostFoundItem

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {

                VStack(spacing: 16) {

                    Image(systemName: iconForCategory(item.category))
                        .font(.system(size: 50))
                        .foregroundStyle(AppTheme.primary)
                        .frame(width: 120, height: 120)
                        .background(AppTheme.primary.opacity(0.12))
                        .cornerRadius(30)

                    Text(item.title)
                        .font(.title)
                        .fontWeight(.bold)

                    Text("\(item.reportType.rawValue) • \(item.category.rawValue)")
                        .foregroundStyle(.secondary)
                }

                DetailCard(
                    title: "Location",
                    content: item.locationName
                )

                DetailCard(
                    title: "Description",
                    content: item.itemDescription
                )

                DetailCard(
                    title: "Contact",
                    content: item.contact
                )

                DetailCard(
                    title: "Status",
                    content: item.status.rawValue
                )
            }
            .padding()
            .padding(.bottom, 100)
        }
        .background(AppTheme.background)
        .navigationTitle("Item Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {

                if item.status == .active {
                    Button("Resolve") {
                        item.status = .resolved
                        try? modelContext.save()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }

    // chooses an icon based on the item category
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

struct DetailCard: View {

    let title: String
    let content: String

    var body: some View {

        VStack(alignment: .leading, spacing: 8) {

            Text(title)
                .font(.headline)

            Text(content)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.white)
        .cornerRadius(AppTheme.cornerRadius)
    }
}

#Preview {

    let sampleItem = LostFoundItem(
        title: "AirPods Pro",
        itemDescription: "White AirPods Pro case lost near the study area around 2PM.",
        reportType: .lost,
        category: .electronics,
        status: .active,
        university: .uts,
        locationName: "UTS Library",
        latitude: -33.8832,
        longitude: 151.2009,
        contact: "andrio@student.uts.edu.au",
        createdByUserID: "preview-user"
    )

    NavigationStack {
        ItemDetailView(item: sampleItem)
    }
    .modelContainer(for: LostFoundItem.self, inMemory: true)
}
