//
//  Enums.swift
//  CampusLost
//
//  Created by Hyeok In on 5/5/2026.
//

import Foundation

//uni list selected by the user
//raw string + storable (swift data) + uni.allcases available + for each usuable
enum University: String, Codable, CaseIterable, Identifiable {

    case uts = "University of Technology Sydney"
    case usyd = "University of Sydney"
    case unsw = "UNSW Sydney"
    case other = "Other"

    var id: String { rawValue }
}

// identifies whether the item was lost or found
enum ReportType: String, Codable, CaseIterable, Identifiable {

    case lost = "Lost"
    case found = "Found"

    var id: String { rawValue }
}

//item categories selected for reports
//for easier filtering and searching
    enum ItemCategory: String, Codable, CaseIterable, Identifiable {
        case electronics = "Electronics"
        case cards = "Cards/ID"
        case clothing = "Clothing"
        case books = "Books/Stationery"
        case bottles = "Bottles"
        case keys = "Keys"
        case bags = "Bags"
        case other = "Other"

        var id: String { rawValue }
    }

//current state of report
//active = visible & resolved = hidden (maybe?)
    enum ReportStatus: String, Codable, CaseIterable, Identifiable {
        case active = "Active"
        case resolved = "Resolved"

        var id: String { rawValue }
    }
