//
//  MapView.swift
//  CampusLost
//
//  Created by Andrio Raymond Ricardo on 6/5/2026.
//

import SwiftUI
import SwiftData
import MapKit

struct MapView: View {

    // gets all saved reports from SwiftData
    @Query private var items: [LostFoundItem]

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: -33.8830,
            longitude: 151.2006
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01
        )
    )

    // only active items are shown on the map
    var activeItems: [LostFoundItem] {
        items.filter { item in
            item.status == .active
        }
    }

    var body: some View {

        NavigationStack {

            ZStack(alignment: .top) {

                Map(
                    coordinateRegion: $region,
                    annotationItems: activeItems
                ) { item in

                    MapAnnotation(
                        coordinate: CLLocationCoordinate2D(
                            latitude: item.latitude,
                            longitude: item.longitude
                        )
                    ) {

                        NavigationLink {

                            ItemDetailView(item: item)

                        } label: {

                            VStack(spacing: 4) {

                                Image(
                                    systemName: item.reportType == .lost
                                    ? "exclamationmark.circle.fill"
                                    : "checkmark.circle.fill"
                                )
                                .font(.title)
                                .foregroundStyle(
                                    item.reportType == .lost
                                    ? .red
                                    : .green
                                )

                                Text(item.title)
                                    .font(.caption2)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 3)
                                    .background(.white)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 6) {

                    Text("Campus Map")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Tap a pin to view item details.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(22)
                .padding()
            }
        }
    }
}

#Preview {
    MapView()
        .modelContainer(for: LostFoundItem.self, inMemory: true)
}
