//
//  ItemRowView.swift
//  CampusLost
//
//  Created by Andrio Raymond Ricardo on 6/5/2026.
//

import SwiftUI

struct ItemRowView: View {

    let icon: String
    let title: String
    let subtitle: String
    let location: String

    var body: some View {

        HStack(spacing: 16) {

            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(AppTheme.primary)
                .frame(width: 60, height: 60)
                .background(AppTheme.primary.opacity(0.12))
                .cornerRadius(16)

            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Label(location, systemImage: "mappin.and.ellipse")
                    .font(.caption)
                    .foregroundStyle(AppTheme.primary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(AppTheme.card)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(
            color: .black.opacity(0.05),
            radius: 8,
            x: 0,
            y: 4
        )
    }
}

#Preview {
    ItemRowView(
        icon: "headphones",
        title: "AirPods Pro",
        subtitle: "Lost • Electronics",
        location: "UTS Library"
    )
    .padding()
    .background(AppTheme.background)
}
