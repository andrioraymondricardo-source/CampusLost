//
//  ItemFilterViewModel.swift
//  CampusLost
//
//  Created by Hein Htet Aung on 9/5/2026.
//

import Foundation
import Combine

final class ItemFilterViewModel: ObservableObject{
    
    @Published var searchText = ""
    @Published var selectedReportType: ReportType? = nil
    @Published var selectedCategory: ItemCategory? = nil
    @Published var showResolvedItems: Bool = false
    
    func filter(
        items: [LostFoundItem],
        selectedUniversity: University
    ) -> [LostFoundItem]{
        items.filter {item in
            let matchesUniversity = item.university == selectedUniversity
            
            let matchesStatus = showResolvedItems ? true : item.status == .active
            
            let matchesReportType = selectedReportType == nil || item.reportType == selectedReportType
            
            let matchesCategory = selectedCategory == nil || item.category == selectedCategory
            
            let matchesSearch = searchText.isEmpty || item.title.localizedCaseInsensitiveContains(searchText) || item.itemDescription.localizedCaseInsensitiveContains(searchText) || item.locationName.localizedCaseInsensitiveContains(searchText) || item.category.rawValue.localizedCaseInsensitiveContains(searchText)
                
            
            return matchesUniversity && matchesStatus && matchesReportType && matchesCategory && matchesSearch
            
        }
    }
    
}
