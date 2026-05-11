//
//  MapViewModel.swift
//  CampusLost
//
//  Created by Hein Htet Aung on 9/5/2026.
//

import Foundation
import MapKit
import Combine

final class MapViewModel: ObservableObject {
    
    @Published private(set) var items: [LostFoundItem] = []
    @Published var selectedCategory: ItemCategory? = nil
    @Published var selectedType: ReportType? = nil
    @Published var selectedBuilding: String = "Main Campus"
    @Published var selectedStatus: ReportStatus = .active
    
    private let mainCampusSpan: Double = 0.018
    private let buildingSpan: Double = 0.001
    
    private let storageManager = LostFoundStorageManager()
    
    func loadItems(){
        items = storageManager.loadItems()
    }
    
    func filteredItems(for university: University) -> [LostFoundItem] {
        return items.filter { item in
            let matchesUniversity = item.university == university
            let matchesStatus = item.status == selectedStatus
            let matchesCategory = selectedCategory == nil || item.category == selectedCategory
            let matchesType = selectedType == nil || selectedType == item.reportType
            
            return matchesUniversity && matchesStatus && matchesCategory && matchesType
        }
    }
    
    func visibleItems(
        from items: [LostFoundItem],
        in region: MKCoordinateRegion
    ) -> [LostFoundItem] {
        items.filter { item in
            region.contains(
                latitude: item.latitude,
                longitude: item.longitude
            )
        }
    }
    
    func region(for location: CampusLocation, spanDelta: Double) -> MKCoordinateRegion {
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: location.latitude,
                longitude: location.longitude
            ),
            span: MKCoordinateSpan(
                latitudeDelta: spanDelta,
                longitudeDelta: spanDelta
            )
        )
    }
    
    func selectMainCampus(from locations: [CampusLocation]) -> MKCoordinateRegion? {
        guard let mainCampus = locations.first else {
            return nil
        }
        
        selectedBuilding = "Main Campus"
        
        return region(for: mainCampus, spanDelta: mainCampusSpan)
    }
    
    func selectBuilding(_ location: CampusLocation) -> MKCoordinateRegion {
        selectedBuilding = location.name
        
        return region(for: location, spanDelta: buildingSpan)
    }
    
}
    
extension MKCoordinateRegion{
    func contains(latitude: Double, longitude: Double) -> Bool {
        let minLatitude = center.latitude - span.latitudeDelta/2
        let maxLatitude = center.latitude + span.latitudeDelta/2
        
        let minLongitude = center.longitude - span.longitudeDelta/2
        let maxLongitude = center.longitude + span.longitudeDelta/2
        
        return latitude >= minLatitude &&
        latitude <= maxLatitude &&
        longitude >= minLongitude &&
        longitude <= maxLongitude
    }
}
