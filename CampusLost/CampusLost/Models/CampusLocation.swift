//
//  CampusLocation.swift
//  CampusLost
//
//  Created by Hyeok In on 5/5/2026.
//

import Foundation

// Represents a predefined campus location used for map navigation and report placement.
struct CampusLocation: Identifiable, Hashable {
    //ID for lists and map
    let id = UUID()
    
    //location belongs to this
    let university: University
    
    //display name
    let name: String
    
    //Coordinates used by MapKit for map centering and report pins.
    let latitude: Double
    let longitude: Double
}
