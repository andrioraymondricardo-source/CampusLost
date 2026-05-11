//
//  ReportLocationPickerView.swift
//  CampusLost
//
//  Created by Hein Htet Aung on 10/5/2026.
//
import SwiftUI
import MapKit

//This view is specifically called by the AddReportView to pick out a certain latitude and longitude for an item when adding reports.
struct ReportLocationPickerView: View {
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var viewModel: AddReportViewModel

    let startingLocation: CampusLocation

    @State private var cameraPosition: MapCameraPosition
    @State private var currentCenterCoordinate: CLLocationCoordinate2D

    init(
        viewModel: AddReportViewModel,
        startingLocation: CampusLocation
    ) {
        self.viewModel = viewModel
        self.startingLocation = startingLocation

        let startingCoordinate = CLLocationCoordinate2D(
            latitude: startingLocation.latitude,
            longitude: startingLocation.longitude
        )

        let startingRegion = MKCoordinateRegion(
            center: startingCoordinate,
            span: MKCoordinateSpan(
                latitudeDelta: 0.003,
                longitudeDelta: 0.003
            )
        )

        self._cameraPosition = State(initialValue: .region(startingRegion))
        self._currentCenterCoordinate = State(initialValue: startingCoordinate)
    }

    var body: some View {
        ZStack {
            Map(position: $cameraPosition)
                .onMapCameraChange { context in
                    currentCenterCoordinate = context.region.center
                }
                .ignoresSafeArea(edges: .bottom)

            VStack(spacing: 6) {
                Image(systemName: "mappin.circle.fill")
                    .font(.system(size: 42))
                    .foregroundStyle(.red)

                Text("Move map under pin")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.white)
                    .clipShape(Capsule())
                    .shadow(radius: 2)
            }

            VStack {
                Spacer()

                VStack(alignment: .leading, spacing: 12) {
                    Text("Set exact location")
                        .font(.headline)

                    Text("Move the map until the pin is above the correct spot, then tap Use This Location.")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Button {
                        viewModel.setPinnedLocation(
                            latitude: currentCenterCoordinate.latitude,
                            longitude: currentCenterCoordinate.longitude
                        )
                        dismiss()
                    } label: {
                        Text("Use This Location")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AppTheme.primary)
                            .cornerRadius(AppTheme.cornerRadius)
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .padding()
            }
        }
        .navigationTitle("Set Location")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview{
    ReportLocationPickerView(viewModel: AddReportViewModel(), startingLocation: CampusLocation(
        university: .uts, name: "UTS Library", latitude: -33.8836, longitude: 151.2009
    ))
}
