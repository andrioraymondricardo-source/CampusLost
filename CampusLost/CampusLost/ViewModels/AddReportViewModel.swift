//
//  AddReportViewModel.swift
//  CampusLost
//
//  Created by Hein Htet Aung on 9/5/2026.
//

import Foundation
import Combine

final class AddReportViewModel: ObservableObject {

    @Published  var title = ""
    @Published  var reportType: ReportType = .lost
    @Published  var category: ItemCategory = .electronics
    @Published  var location = ""
    @Published  var description = ""
    @Published  var contact = ""
    @Published  var errorMessage = ""
    @Published var selectedLatitude: Double? = nil
    @Published var selectedLongitude: Double? = nil
    
    var hasSelectedMapLocation: Bool {
        selectedLatitude != nil && selectedLongitude != nil
    }
    
    func setDefaultLocationIfRequired(from locations: [CampusLocation]){
        if location.isEmpty{
            location = locations.first?.name ?? ""
        }
    }
    
    func submitReport(
        selectedUniversity: University,
        locations: [CampusLocation]
    ) -> Bool {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedDescription = description.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedContact = contact.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedTitle.isEmpty else {
            errorMessage = "Please enter an item title."
            return false
        }
        
        guard !trimmedDescription.isEmpty else {
            errorMessage = "Please enter a description."
            return false
        }
        
        guard !trimmedContact.isEmpty else {
            errorMessage = "Please enter contact information."
            return false
        }
        
        guard let selectedLocation = locations.first(where: {$0.name == location})else {
            errorMessage = "Please select a campus location."
            return false
        }
        
        guard let _ = selectedLatitude,
              let _ = selectedLongitude else {
            errorMessage = "Please set the exact location on the map."
            return false
        }
        
        let creatorID = UserManager.getOrCreateUserID()
        
        if let latitude = selectedLatitude, let longitude = selectedLongitude {
            let newItem = LostFoundItem(
                title: trimmedTitle,
                itemDescription: trimmedDescription,
                reportType: reportType,
                category: category,
                status: .active,
                university: selectedUniversity,
                locationName: selectedLocation.name,
                latitude: latitude,
                longitude: longitude,
                dateReported: Date(),
                contact: trimmedContact,
                createdByUserID: creatorID
            )
            
            LostFoundStorageManager().addItem(newItem)
            return true
        }
    
        return false
    }
    
    func clearForm(locations: [CampusLocation]) {
        title = ""
        reportType = ReportType.lost
        category = ItemCategory.electronics
        location = locations[0].name
        description = ""
        contact = ""
        selectedLatitude = nil
        selectedLongitude = nil
    }
    
    func fillLocation(locations: [CampusLocation]){
        if location.isEmpty {
            location = locations[0].name
        }
        
    }
    
    func setPinnedLocation(latitude: Double, longitude: Double){
        selectedLongitude = longitude
        selectedLatitude = latitude
    }
    
}
