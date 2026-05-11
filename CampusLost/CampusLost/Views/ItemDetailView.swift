//
//  ItemDetailView.swift
//  CampusLost
//
//  Created by Andrio Raymond Ricardo on 6/5/2026.
//

import SwiftUI

struct ItemDetailView: View {

    let item: LostFoundItem

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {

                VStack(spacing: 16) {

                    Image(systemName: item.category.iconName)
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
                    content: "Active"
                )

                Button {

                } label: {

                    Text("Mark as Resolved")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppTheme.primary)
                        .cornerRadius(AppTheme.cornerRadius)
                }
            }
            .padding()
        }
        .background(AppTheme.background)
        .navigationTitle("Item Details")
        .navigationBarTitleDisplayMode(.inline)
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

    ItemDetailView(
        item: LostFoundItem(title: "AirPods Pro", itemDescription: "White AirPods Pro case lost near the study area around 2PM.", reportType: .lost, category: .electronics, university: .uts, locationName: "UTS Library", latitude: -33.88326180111422, longitude: 151.20061189923524, contact: "andrio@student.uts.edu.au", createdByUserID: "UUID()")
    )
}
