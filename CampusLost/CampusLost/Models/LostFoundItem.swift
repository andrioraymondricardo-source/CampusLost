//
//  LostFoundItem.swift
//  CampusLost
//
//  Created by Hyeok In on 5/5/2026.
//

import Foundation

//data model for lost & found item reports

struct LostFoundItem : Identifiable, Codable, Equatable {
    
    //basic item info
    let id: UUID
    var title: String
    var itemDescription: String
    
    //report class
    //used enum for filtering & prevent invalid values
    var reportType: ReportType
    var category: ItemCategory
    var status: ReportStatus
    
    //location info
    //name displayed in the ui
    //coordinates for mapkit pins later
    var university: University
    var locationName: String
    var latitude: Double
    var longitude: Double
    
    //report data (can call it metadata? maybe)
    var dateReported: Date
    var contact: String
    
    //local creator ID
    //only the creator can edit/delete/resolve
    var createdByUserID: String
    
    //initialiser
    init(
            id: UUID = UUID(),
            title: String,
            itemDescription: String,
            reportType: ReportType,
            category: ItemCategory,
            status: ReportStatus = .active,
            university: University,
            locationName: String,
            latitude: Double,
            longitude: Double,
            dateReported: Date = Date(),
            contact: String,
            createdByUserID: String
        ) {
            self.id = id
            self.title = title
            self.itemDescription = itemDescription
            self.reportType = reportType
            self.category = category
            self.status = status
            self.university = university
            self.locationName = locationName
            self.latitude = latitude
            self.longitude = longitude
            self.dateReported = dateReported
            self.contact = contact
            self.createdByUserID = createdByUserID
        }
}
