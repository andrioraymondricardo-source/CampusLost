//
//  LostFoundItemMapExtension.swift
//  CampusLost
//
//  Created by Hein Htet Aung on 9/5/2026.
//
import MapKit

extension LostFoundItem {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
