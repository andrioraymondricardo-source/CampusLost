//
//  LostFoundStorageManager.swift
//  CampusLost
//
//  Created by Hein Htet Aung on 10/5/2026.
//
import Foundation

final class LostFoundStorageManager {
    private let storageKey = "lostFoundItems"
    
    func loadItems() -> [LostFoundItem] {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else {
            return []
        }
        
        let decoder = JSONDecoder()
        do {
            let items = try decoder.decode([LostFoundItem].self, from: data)
            return items
        } catch {
            print("Failed to load items: \(error.localizedDescription)")
            return []
        }
    }
    
    func saveItems(_ items: [LostFoundItem]) {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: storageKey)
        }catch{
            print("Failed to save items: \(error.localizedDescription)")
        }
    }
    
    func addItem(_ item: LostFoundItem){
        var items = loadItems()
        items.append(item)
        saveItems(items)
    }
    
    func updateItem(_ updatedItem: LostFoundItem){
        var items = loadItems()
        
        guard let index = items.firstIndex(where: {$0.id == updatedItem.id}) else {
            return
        }
        
        items[index] = updatedItem
        saveItems(items)
    }
    
    func deleteItem(_ item: LostFoundItem){
        var items = loadItems()
        items.removeAll{$0.id == item.id}
        saveItems(items)
    }
    
}
