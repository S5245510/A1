//
//  ChecklistViewModel.swift
//  A1
//
//  Created by Tsz Hoi Leung on 02/04/2023.
//
// ChecklistViewModel.swift
import Foundation

class ChecklistViewModel: ObservableObject {
    @Published var items: [ChecklistItem] = [
        ChecklistItem(name: "Buy groceries", isChecked: true, detail: "Rice, Milk, Egg"),
        ChecklistItem(name: "Study", isChecked: true, detail: "Revision"),
        ChecklistItem(name: "Clean house", isChecked: false, detail: "Sweep floors"),
        ChecklistItem(name: "Exercise", isChecked: false, detail: "Go for a gym")
    ]
    
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
    
    func resetCheck() {
        items = items.map { item in
            ChecklistItem(
                id: item.id,
                name: item.name,
                isChecked: false,
                detail: item.detail
            )
        }
        saveItems()
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
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let loadedItems = try JSONDecoder().decode([ChecklistItem].self, from: data)
            items = loadedItems
        } catch {
            print("Failed to load items: \(error.localizedDescription)")
        }
    }
    
    private func getFile() -> URL? {
        let filename = "checklist.json"
        let fm = FileManager.default
        guard let url = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(filename)
    }
}
