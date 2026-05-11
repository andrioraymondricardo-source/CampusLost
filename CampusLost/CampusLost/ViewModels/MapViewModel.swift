//
//  MapViewModel.swift
//  CampusLost
//
//  Created by Hein Htet Aung on 9/5/2026.
//

import Foundation
import MapKit
import Combine

//A view model class used by MapView
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
    
    //This function will only return items that are visible on the screen
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
    
    //This function will return a MKCoordinateRegion that is visible on the user's screen
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
    
    //This function is called when the main campus is selected in each map view.
    func selectMainCampus(from locations: [CampusLocation]) -> MKCoordinateRegion? {
        guard let mainCampus = locations.first else {
            return nil
        }
        
        selectedBuilding = "Main Campus"
        
        return region(for: mainCampus, spanDelta: mainCampusSpan)
    }
    
    //This function is called when separate buildings are selected in each map view. The spanDelta for these two functions are different.
    func selectBuilding(_ location: CampusLocation) -> MKCoordinateRegion {
        selectedBuilding = location.name
        
        return region(for: location, spanDelta: buildingSpan)
    }
    
}

//This is an extension to the built-in MKCoordinateRegion to include a function called contains that check whether a certain latitude and longitude are included in a certain region.
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
