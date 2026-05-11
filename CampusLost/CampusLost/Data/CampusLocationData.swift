//
//  CampusLocationData.swift
//  CampusLost
//
//  Created by Hyeok In on 5/5/2026.
//

import Foundation

// campus locations for each university
// replaces GPS-based input for the MVP
struct CampusLocationData {
    
    // All available locations (currently, asked ChatGPT for coordinates only for UTS)
    static let locations: [CampusLocation] = [
        CampusLocation(
            university: .uts,
            name: "UTS",
            latitude: -33.88326180111422,
            longitude: 151.20061189923524
        ),
        CampusLocation(
            university: .uts,
            name: "UTS Library",
            latitude: -33.8832,
            longitude: 151.2009
        ),
        CampusLocation(
            university: .uts,
            name: "Building 1",
            latitude: -33.8836,
            longitude: 151.2008
        ),
        CampusLocation(
            university: .uts,
            name: "Building 2",
            latitude: -33.8840,
            longitude: 151.2005
        ),
        CampusLocation(
            university: .uts,
            name: "Building 10",
            latitude: -33.8846,
            longitude: 151.2002
        ),
        CampusLocation(
            university: .uts,
            name: "Building 11",
            latitude: -33.8838,
            longitude: 151.2019
        ),
        CampusLocation(
            university: .uts,
            name: "Alumni Green",
            latitude: -33.8839,
            longitude: 151.2009
        )
    ]
    
    //only for the selected uni
    static func locations(for university: University) -> [CampusLocation] {
        locations.filter { $0.university == university }
    }
}
