//
//  LostFoundItem.swift
//  CampusLost
//
//  Created by Hyeok In on 5/5/2026.
//

import Foundation
import SwiftData

@Model
final class LostFoundItem {

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

    // used by UI as enum
    var reportType: ReportType {
        get {
            ReportType(rawValue: reportTypeRaw) ?? .lost
        }
        set {
            reportTypeRaw = newValue.rawValue
        }
    }

    // used by UI as enum
    var category: ItemCategory {
        get {
            ItemCategory(rawValue: categoryRaw) ?? .other
        }
        set {
            categoryRaw = newValue.rawValue
        }
    }

    // used by UI as enum
    var status: ReportStatus {
        get {
            ReportStatus(rawValue: statusRaw) ?? .active
        }
        set {
            statusRaw = newValue.rawValue
        }
    }

    // used by UI as enum
    var university: University {
        get {
            University(rawValue: universityRaw) ?? .uts
        }
        set {
            universityRaw = newValue.rawValue
        }
    }

    init(
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
        self.title = title
        self.itemDescription = itemDescription
        self.reportTypeRaw = reportType.rawValue
        self.categoryRaw = category.rawValue
        self.statusRaw = status.rawValue
        self.universityRaw = university.rawValue
        self.locationName = locationName
        self.latitude = latitude
        self.longitude = longitude
        self.dateReported = dateReported
        self.contact = contact
        self.createdByUserID = createdByUserID
    }
}
