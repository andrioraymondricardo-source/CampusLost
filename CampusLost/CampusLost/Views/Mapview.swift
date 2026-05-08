//
//  Mapview.swift
//  CampusLost
//
//  Created by Andrio Raymond Ricardo on 6/5/2026.
//

import SwiftUI
import MapKit

struct MapView: View {

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

    var body: some View {

        NavigationStack {

            Map(coordinateRegion: $region)
                .ignoresSafeArea()
                .navigationTitle("Campus Map")
        }
    }
}

#Preview {
    MapView()
}
