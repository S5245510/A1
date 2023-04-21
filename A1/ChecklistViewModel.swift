//
//  ChecklistViewModel.swift
//  A1
//
//  Created by Tsz Hoi Leung on 02/04/2023.
//
// ChecklistViewModel.swift
import Foundation

class ChecklistViewModel: ObservableObject {
    // default 4 items when the app first builded
    @Published var items: [ChecklistItem] = [
        ChecklistItem(name: "Buy groceries", isChecked: true, detail: "Rice, Milk, Egg"),
        ChecklistItem(name: "Study", isChecked: true, detail: "Revision"),
        ChecklistItem(name: "Clean house", isChecked: false, detail: "Sweep floors"),
        ChecklistItem(name: "Exercise", isChecked: false, detail: "Go for a gym")
    ]
    
    // to add items in checklist
    func addItems() {
        let newItem = ChecklistItem(name: "New routine", isChecked: false, detail: "routine detail")
        items.append(newItem)
        saveItems()
    }
      // to delete items in checklist by passing the index
    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        saveItems()
    }
    // edit item names in checklist
    func editItems(item: ChecklistItem, name: String) {
        if let index = items.firstIndex(of: item) {
            items[index].name = name
            saveItems()
        }
    }
    // edit details of items
    func editDetails(item: ChecklistItem, detail: String) {
        if let index = items.firstIndex(of: item) {
            items[index].detail = detail
            saveItems()
        }
    }
    // reset all checkmark bool to false
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
    
    // re-ordering
    func moveItems(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
        saveItems()
    }


    // all above func will use this to save and update to json file
    func saveItems() {
        guard let url = getFile() else { return }
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: url)
        } catch {
            print("Failed to save items: \(error.localizedDescription)")
        }
    }
    
    

     // get item data from json if there is one found
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
    
    
    // when
    private func getFile() -> URL? {
        // the json file name
        let filename = "checklist.json"
        // to allow to access directory
        let fm = FileManager.default
        guard let url = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        // to create a url to the file
        return url.appendingPathComponent(filename)
    }
}
