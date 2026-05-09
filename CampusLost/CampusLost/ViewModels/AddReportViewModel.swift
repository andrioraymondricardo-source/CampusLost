//
//  AddReportViewModel.swift
//  CampusLost
//
//  Created by Hein Htet Aung on 9/5/2026.
//

import Foundation
import SwiftData
import Combine

final class AddReportViewModel: ObservableObject {

    @Published  var title = ""
    @Published  var reportType: ReportType = .lost
    @Published  var category: ItemCategory = .electronics
    @Published  var location = ""
    @Published  var description = ""
    @Published  var contact = ""
    @Published  var errorMessage = ""
    
    func setDefaultLocationIfRequired(from locations: [CampusLocation]){
        if location.isEmpty{
            location = locations.first?.name ?? ""
        }
    }
    
    func submitReport(
        modelContext: ModelContext,
        selectedUniversity: University,
        locations: [CampusLocation],
        currentUserID: String
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
        
        let creatorID = UserManager.getOrCreateUserID()
        
        let newItem = LostFoundItem(
            title: trimmedTitle,
            itemDescription: trimmedDescription,
            reportType: reportType,
            category: category,
            status: .active,
            university: selectedUniversity,
            locationName: selectedLocation.name,
            latitude: selectedLocation.latitude,
            longitude: selectedLocation.longitude,
            dateReported: Date(),
            contact: trimmedContact,
            createdByUserID: creatorID
        )
        
        modelContext.insert(newItem)
        
        do{
            try modelContext.save()
            errorMessage = ""
            clearForm(defaultLocationName: locations[0].name)
            return true
        }catch{
            errorMessage = "Failed to save report. Please try again."
            print("Failed to save report: \(error.localizedDescription)")
            return false
        }
    }
    
    private func clearForm(defaultLocationName: String) {
        title = ""
        reportType = ReportType.lost
        category = ItemCategory.electronics
        location = defaultLocationName
        description = ""
        contact = ""
    }
    
    func fillLocation(locations: [CampusLocation]){
        location = locations[0].name
    }
    
}
