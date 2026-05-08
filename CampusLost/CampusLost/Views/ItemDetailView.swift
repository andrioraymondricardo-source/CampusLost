//
//  ItemDetailView.swift
//  CampusLost
//
//  Created by Andrio Raymond Ricardo on 6/5/2026.
//

import SwiftUI

struct ItemDetailView: View {

    let item: SampleItem

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {

                VStack(spacing: 16) {

                    Image(systemName: item.icon)
                        .font(.system(size: 50))
                        .foregroundStyle(AppTheme.primary)
                        .frame(width: 120, height: 120)
                        .background(AppTheme.primary.opacity(0.12))
                        .cornerRadius(30)

                    Text(item.title)
                        .font(.title)
                        .fontWeight(.bold)

                    Text("\(item.type) • \(item.category)")
                        .foregroundStyle(.secondary)
                }

                DetailCard(
                    title: "Location",
                    content: item.location
                )

                DetailCard(
                    title: "Description",
                    content: item.description
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
        item: SampleItem(
            icon: "headphones",
            title: "AirPods Pro",
            type: "Lost",
            category: "Electronics",
            location: "UTS Library",
            description: "White AirPods Pro case lost near the study area around 2PM.",
            contact: "andrio@student.uts.edu.au"
        )
    )
}
