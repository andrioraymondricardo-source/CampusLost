//
//  CampusLocation.swift
//  CampusLost
//
//  Created by Hyeok In on 5/5/2026.
//

import Foundation

//predefined campus locattion -> havent looked at Mapkit yet. initial step only. whoever does mapkit import, prolly needs this
//Hein said there is an API for this? let's see

struct CampusLocation: Identifiable, Hashable {
    //ID for lists and map
    let id = UUID()
    
    //location belongs to this
    let university: University
    
    //display name
    let name: String
    
    //coordinates? idk if we need this
    let latitude: Double
    let longitude: Double
}
