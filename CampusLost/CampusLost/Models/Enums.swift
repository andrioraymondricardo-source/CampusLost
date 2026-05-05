//
//  Enums.swift
//  CampusLost
//
//  Created by Hyeok In on 5/5/2026.
//

import Foundation

enum University: String, Codable, CaseIterable, Identifiable {
    case uts = "University of Technology Sydney"
    case usyd = "University of Sydney"
    case unsw = "University of New South Wales"
    case uow = "University of Western Australia"
    case other = "Other"
    
    var id: String { rawValue }
}


