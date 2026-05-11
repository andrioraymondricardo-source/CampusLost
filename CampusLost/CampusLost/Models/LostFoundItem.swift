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

    // SwiftData stores enum values as String for stability
    var reportTypeRaw: String
    var categoryRaw: String
    var statusRaw: String
    var universityRaw: String

    var locationName: String
    var latitude: Double
    var longitude: Double

    var dateReported: Date
    var contact: String
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
