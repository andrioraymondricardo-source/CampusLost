//
//  MapView.swift
//  CampusLost
//
//  Created by Andrio Raymond Ricardo on 6/5/2026.
//

import SwiftUI
import MapKit
import Combine

struct MapView: View {

    @AppStorage("selectedUniversity") private var selectedUniversityRawValue: String = University.uts.rawValue
    
    @StateObject private var mapViewModel = MapViewModel()
    
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 0,
                longitude: 0
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.05,
                longitudeDelta: 0.05
            )
        )
    )
    
    @State private var visibleRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 0,
            longitude: 0
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.05,
            longitudeDelta: 0.05
        )
    )
    
    private var selectedUniversity: University {
        University(rawValue: selectedUniversityRawValue) ?? .uts
    }
    
    private var campusLocation: [CampusLocation]{
        CampusLocationData.locations(for: selectedUniversity)
    }
    
    private var mapItems: [LostFoundItem] {
        mapViewModel.filteredItems(for: selectedUniversity)
    }
    
    private var visibleItems: [LostFoundItem] {
        mapViewModel.visibleItems(
            from: mapItems,
            in: visibleRegion
        )
    }

    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottom){
                mapLayer
                
                VStack(spacing: 12){
                    Spacer()
                    
                    visibleItemsPanel
                }
            }
            .overlay(alignment: .top){
                topControls
            }
                .onAppear{
                    mapViewModel.loadItems()
                    
                    if let mainCampusRegion = mapViewModel.selectMainCampus(from: campusLocation){
                            cameraPosition = .region(mainCampusRegion)
                            visibleRegion = mainCampusRegion
                        }
                    }
                }
        
        }
    
    private var mapLayer: some View {
        Map(position: $cameraPosition){
            ForEach(mapItems){item in
                Annotation(
                    item.title,
                    coordinate: CLLocationCoordinate2D(
                        latitude: item.latitude,
                        longitude: item.longitude
                    )
                ){
                    NavigationLink{
                        ItemDetailView(item: item)
                    }label: {
                        mapPin(for: item)
                    }
                }
            }
        }
        .onMapCameraChange {context in
            visibleRegion = context.region
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
    private func iconName(for category: ItemCategory) -> String {
        category.iconName
    }
    
    private func mapPin(for item: LostFoundItem) -> some View {
        VStack(spacing: 4){
            Image(systemName: iconName(for: item.category))
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .padding(10)
                .background(item.reportType == .found ? Color.green : Color.red)
                .clipShape(Circle())
                .shadow(radius: 4)
            
            Text(item.title)
                .font(.caption2)
                .fontWeight(.semibold)
                .lineLimit(1)
                .padding(.horizontal, 6)
                .padding(.vertical, 3)
                .background(.white)
                .clipShape(Capsule())
                .shadow(radius: 2)
        }
    }
    
    private var topControls: some View{
        VStack(spacing: 10){
            buildingButtons
            
            categoryButtons
        }
        .padding(.top, 8)
        .padding(.horizontal)
        .background(.ultraThinMaterial)
    }
    
    private var buildingButtons: some View {
        HStack{
            Text("Location: ")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    Button {
                        if let mainCampusRegion = mapViewModel.selectMainCampus(from: campusLocation){
                                cameraPosition = .region(mainCampusRegion)
                                visibleRegion = mainCampusRegion
                        }
                    } label: {
                        filterChip(
                            title: "Main Campus",
                            isSelected: mapViewModel.selectedBuilding == "Main Campus"
                        )
                    }
                    
                    ForEach(campusLocation.dropFirst()) { location in
                        Button {
                            cameraPosition = .region(mapViewModel.selectBuilding(location))
                            visibleRegion = mapViewModel.selectBuilding(location)
                        } label: {
                            filterChip(
                                title: location.name,
                                isSelected: mapViewModel.selectedBuilding == location.name
                            )
                        }
                    }
                }
                .padding(.horizontal, 4)
            }
        }
    }

    private var categoryButtons: some View {
        HStack{
            Text("Category:")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    Button {
                        mapViewModel.selectedCategory = nil
                    } label: {
                        filterChip(
                            title: "All",
                            isSelected: mapViewModel.selectedCategory == nil
                        )
                    }
                    
                    ForEach(ItemCategory.allCases, id: \.self) { category in
                        Button {
                            mapViewModel.selectedCategory = category
                        } label: {
                            filterChip(
                                title: category.rawValue,
                                isSelected: mapViewModel.selectedCategory == category
                            )
                        }
                    }
                }
                .padding(.horizontal, 4)
            }
        }
    }

    private func filterChip(
        title: String,
        isSelected: Bool
    ) -> some View {
        Text(title)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                isSelected
                ? AppTheme.primary
                : Color.white
            )
            .foregroundStyle(
                isSelected
                ? .white
                : AppTheme.primary
            )
            .clipShape(Capsule())
            .shadow(radius: 1)
    }

    private var visibleItemsPanel: some View {
        VStack(alignment: .leading, spacing: 12) {
            Capsule()
                .frame(width: 44, height: 5)
                .foregroundStyle(.secondary.opacity(0.4))
                .frame(maxWidth: .infinity)

            HStack {
                Text("Items in this area")
                    .font(.headline)

                Spacer()

                Text("\(visibleItems.count)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            if visibleItems.isEmpty {
                Text("No active reports visible in this map area.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.vertical, 8)
            } else {
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(visibleItems) { item in
                            NavigationLink {
                                ItemDetailView(item: item)
                            } label: {
                                HStack(spacing: 12) {
                                    Image(systemName:  item.category.iconName)
                                        .foregroundStyle(AppTheme.primary)
                                        .frame(width: 28)

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(item.title)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.primary)

                                        Text("\(item.reportType.rawValue) • \(item.category.rawValue)")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }

                                    Spacer()

                                    Text(item.locationName)
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)
                                }
                                .padding()
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .frame(maxHeight: 220)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 24,
                style: .continuous
            )
        )
        .padding(.horizontal)
        .padding(.bottom, 12)
    }
}

#Preview {
    MapView()
}

