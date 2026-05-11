//
//  ItemDetailView.swift
//  CampusLost
//
//  Created by Andrio Raymond Ricardo on 6/5/2026.
//

import SwiftUI

//This is a page that details all information of a certain report.
struct ItemDetailView: View {

    let item: LostFoundItem
    
    @Binding var refreshTrigger: UUID
    
    @State private var resolvedAlert = false
    
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
                    content: item.status.rawValue
                )
            }
            .padding()
        }
        .background(AppTheme.background)
        .navigationTitle("Item Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                if item.status == .active && item.createdByUserID == UserManager.getOrCreateUserID() {
                    Button("Resolve") {
                        LostFoundStorageManager().updateItemStatus(
                            updatedItem: item,
                            rStatus: .resolved
                        )
                        refreshTrigger = UUID()
                        resolvedAlert = true
                    }
                    .fontWeight(.semibold)
                    .onChange(of: resolvedAlert){
                        if item.status == .resolved {
                            
                        }
                    }
                }
            }
        }
        .alert("Report marked as resolved", isPresented: $resolvedAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Your report has been resolved.")
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

    ItemDetailView(
        item: LostFoundItem(
            title: "AirPods Pro",
            itemDescription: "White AirPods Pro case lost near the study area around 2PM.",
            reportType: .lost,
            category: .electronics,
            status: .active,
            university: .uts,
            locationName: "UTS Library",
            latitude: -33.88326180111422,
            longitude: 151.20061189923524,
            contact: "andrio@student.uts.edu.au",
            createdByUserID: "preview-user"),
        refreshTrigger: .constant(UUID())
    )
}
