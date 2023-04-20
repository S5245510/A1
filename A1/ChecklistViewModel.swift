//
//  ChecklistViewModel.swift
//  A1
//
//  Created by Tsz Hoi Leung on 02/04/2023.
//
// ChecklistViewModel.swift
import Foundation

class ChecklistViewModel: ObservableObject {
    @Published var items: [ChecklistItem] = []
    
    func addItem() {
        let newItem = ChecklistItem(name: "New routine", isChecked: false, detail: "routine detail")
        items.append(newItem)
        saveItems()
    }
        
    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        saveItems()
    }
    
    func editItem(item: ChecklistItem, name: String) {
        if let index = items.firstIndex(of: item) {
            items[index].name = name
            saveItems()
        }
    }
    
    func editDetail(item: ChecklistItem, detail: String) {
        if let index = items.firstIndex(of: item) {
            items[index].detail = detail
            saveItems()
        }
    }
    
    func saveItems() {
        guard let url = getFile() else { return }
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: url)
        } catch {
            print("Failed to save items: \(error.localizedDescription)")
        }
    }
    
    
    func loadItems() {
        guard let url = getFile() else {
            loadDefaultItems()
            saveItems()
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let loadedItems = try JSONDecoder().decode([ChecklistItem].self, from: data)
            items = loadedItems
        } catch {
            loadDefaultItems()
            saveItems()
        }
    }


    private func loadDefaultItems() {
        guard let url = Bundle.main.url(forResource: "defaultItem", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let defaultItems = try? JSONDecoder().decode([ChecklistItem].self, from: data)
        else {
            print("Failed to load default items")
            return
        }
        items = defaultItems
    }
    
    private func getFile() -> URL? {
        let filename = "checklist.json"
        let fm = FileManager.default
        guard let url = fm.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.allDomainsMask).first else {
            return nil
        }
        return url.appendingPathComponent(filename)
    }
}
