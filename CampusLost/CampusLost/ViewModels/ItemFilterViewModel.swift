//
//  ItemFilterViewModel.swift
//  CampusLost
//
//  Created by Hein Htet Aung on 9/5/2026.
//

import Foundation
import Combine

//A view model class utilized by the HomeView that needs to filter items
final class ItemFilterViewModel: ObservableObject{
    
    @Published var searchText = ""
    @Published var selectedReportType: ReportType? = nil
    @Published var selectedCategory: ItemCategory? = nil
    @Published var selectedStatus: ReportStatus = .active
    @Published var itemList: [LostFoundItem] = []
    
    private let storageManager: LostFoundStorageManager = LostFoundStorageManager()
    
    func filter(
        selectedUniversity: University
    ) -> [LostFoundItem]{
        itemList.filter {item in
            let matchesUniversity = item.university == selectedUniversity
            
            let matchesStatus = selectedStatus == item.status
            
            let matchesReportType = selectedReportType == nil || item.reportType == selectedReportType
            
            let matchesCategory = selectedCategory == nil || item.category == selectedCategory
            
            let matchesSearch = searchText.isEmpty || item.title.localizedCaseInsensitiveContains(searchText) || item.itemDescription.localizedCaseInsensitiveContains(searchText) || item.locationName.localizedCaseInsensitiveContains(searchText) || item.category.rawValue.localizedCaseInsensitiveContains(searchText)
                
            
            return matchesUniversity && matchesStatus && matchesReportType && matchesCategory && matchesSearch
            
        }
    }
    
    func loadItems() {
        itemList = storageManager.loadItems()
    }
    
}
