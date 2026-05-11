//
//  CampusLocationData.swift
//  CampusLost
//
//  Created by Hyeok In on 5/5/2026.
//

import Foundation

// campus locations for each university
struct CampusLocationData {
    
    static let locations: [CampusLocation] = [
        CampusLocation(
                    university: .uts,
                    name: "UTS Main Campus",
                    latitude: -33.8836,
                    longitude: 151.2009
                ),

                CampusLocation(
                    university: .uts,
                    name: "Building 1 - UTS Tower",
                    latitude: -33.883305,
                    longitude: 151.200859
                ),

                CampusLocation(
                    university: .uts,
                    name: "Building 2 - UTS Central",
                    latitude: -33.883839,
                    longitude:  151.200092
                ),

                CampusLocation(
                    university: .uts,
                    name: "UTS Library",
                    latitude: -33.883885,
                    longitude:  151.200274
                ),

                CampusLocation(
                    university: .uts,
                    name: "Building 3 - Bon Marche",
                    latitude: -33.88243014842187,
                    longitude:  151.20127973726514
                ),

                CampusLocation(
                    university: .uts,
                    name: "Building 4",
                    latitude: -33.8819531753377,
                    longitude: 151.20152323733566
                ),

                CampusLocation(
                    university: .uts,
                    name: "Building 5 - Haymarket",
                    latitude: -33.879884,
                    longitude: 151.202168
                ),

                CampusLocation(
                    university: .uts,
                    name: "Building 6 - Design, Architecture and Building",
                    latitude: -33.883497,
                    longitude: 151.202128
                ),

                CampusLocation(
                    university: .uts,
                    name: "Building 7",
                    latitude: -33.883313,
                    longitude: 151.200858
                ),

                CampusLocation(
                    university: .uts,
                    name: "Building 8 - Dr Chau Chak Wing Building",
                    latitude: -33.880831,
                    longitude: 151.201220
                ),

                CampusLocation(
                    university: .uts,
                    name: "Building 10",
                    latitude: -33.883456,
                    longitude: 151.199057
                ),

                CampusLocation(
                    university: .uts,
                    name: "Building 11 - Engineering and IT",
                    latitude: -33.884080,
                    longitude: 151.199180
                ),

                CampusLocation(
                    university: .uts,
                    name: "Alumni Green",
                    latitude: -33.883146,
                    longitude: 151.200505
                ),
        
                CampusLocation(
                    university: .usyd,
                    name: "USyd Camperdown/Darlington Campus",
                    latitude: -33.88754866645835,
                    longitude: 151.18685058393382
                ),

                CampusLocation(
                    university: .usyd,
                    name: "The Quadrangle",
                    latitude: -33.88516087358144,
                    longitude: 151.18873885700174
                ),

                CampusLocation(
                    university: .usyd,
                    name: "Fisher Library",
                    latitude: -33.88584330830405,
                    longitude: 151.19053519927326
                ),

                CampusLocation(
                    university: .usyd,
                    name: "New Law Building",
                    latitude: -33.8868944379255,
                    longitude:  151.19067462257124
                ),

                CampusLocation(
                    university: .usyd,
                    name: "Carslaw Building",
                    latitude: -33.88833463067891,
                    longitude: 151.19037819325266
                ),

                CampusLocation(
                    university: .usyd,
                    name: "Eastern Avenue Auditorium",
                    latitude: -33.88726653841573,
                    longitude: 151.1901686072312
                ),

                CampusLocation(
                    university: .usyd,
                    name: "Wentworth Building",
                    latitude: -33.88922358528982,
                    longitude: 151.1904657349007
                ),

                CampusLocation(
                    university: .usyd,
                    name: "Abercrombie Building",
                    latitude: -33.89155589453741,
                    longitude: 151.19131169131936
                ),

                CampusLocation(
                    university: .usyd,
                    name: "Peter Nicol Russell Building",
                    latitude: -33.88946945867829,
                    longitude: 151.19288849189175
                ),

                CampusLocation(
                    university: .usyd,
                    name: "Seymour Centre",
                    latitude: -33.88770816805607,
                    longitude: 151.19370141461488
                ),

                CampusLocation(
                    university: .usyd,
                    name: "Charles Perkins Centre",
                    latitude: -33.88712753366123,
                    longitude: 151.18369952208784
                ),

                CampusLocation(
                    university: .usyd,
                    name: "Susan Wakil Health Building",
                    latitude: -33.887944821049935,
                    longitude: 151.1843724612101
                ),

                CampusLocation(
                    university: .usyd,
                    name: "Jane Foss Russell Building",
                    latitude: -33.8889203756701,
                    longitude: 151.19179943791278
                ),
        
                CampusLocation(
                    university: .unsw,
                    name: "UNSW Kensington Campus",
                    latitude: -33.91154706518756,
                    longitude: 151.23372482711912
                ),

                CampusLocation(
                    university: .unsw,
                    name: "UNSW Main Library",
                    latitude: -33.916344763850844,
                    longitude: 151.23307831520393
                ),

                CampusLocation(
                    university: .unsw,
                    name: "UNSW Business School",
                    latitude: -33.916649336967566,
                    longitude: 151.22962729325272
                ),

                CampusLocation(
                    university: .unsw,
                    name: "Law Building",
                    latitude: -33.91579577293186,
                    longitude: 151.22763128792758
                ),

                CampusLocation(
                    university: .unsw,
                    name: "Roundhouse",
                    latitude: -33.9160104578633,
                    longitude: 151.22708056065161
                ),

                CampusLocation(
                    university: .unsw,
                    name: "Tyree Energy Technologies Building",
                    latitude: -33.91681013394816,
                    longitude: 151.22642784588507
                ),

                CampusLocation(
                    university: .unsw,
                    name: "Ainsworth Building",
                    latitude: -33.91770693121883,
                    longitude: 151.23102226122612
                ),

                CampusLocation(
                    university: .unsw,
                    name: "Chemical Sciences Building",
                    latitude: -33.916643302903914,
                    longitude: 151.2294868650398
                ),

                CampusLocation(
                    university: .unsw,
                    name: "Central Lecture Block",
                    latitude: -33.916480134754714,
                    longitude: 151.23240702258732
                ),

                CampusLocation(
                    university: .unsw,
                    name: "The Red Centre",
                    latitude: -33.917211327455725,
                    longitude: 151.23015762997133
                ),

                CampusLocation(
                    university: .unsw,
                    name: "Wallace Wurth Building",
                    latitude: -33.91571282203101,
                    longitude: 151.23607728394907
                ),

                CampusLocation(
                    university: .unsw,
                    name: "Scientia Building",
                    latitude: -33.917695840760246,
                    longitude: 151.23229329069073
                ),

                CampusLocation(
                    university: .unsw,
                    name: "Blockhouse",
                    latitude: -33.91633172047616,
                    longitude: 151.2265389458847
                ),

                CampusLocation(
                    university: .unsw,
                    name: "Quadrangle Building",
                    latitude: -33.91714222492488,
                    longitude: 151.23126213558248
                )
    ]
    
    //only for the selected uni
    static func locations(for university: University) -> [CampusLocation] {
        locations.filter { $0.university == university }
    }
}
