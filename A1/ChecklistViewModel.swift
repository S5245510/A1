//
//  ChecklistViewModel.swift
//  A1
//

import Foundation

class ChecklistViewModel: ObservableObject {
    @Published var items = [ChecklistItem]()
    
    
    func addItem() {
        let newItem = ChecklistItem(name: "New Item")
            items.append(newItem)
        }
        
    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        }
    
    func moveItems(from source: IndexSet, to destination: Int) {
            items.move(fromOffsets: source, toOffset: destination)
        }
    
    func editItem(item: ChecklistItem, name: String){
        if let index = items.firstIndex(of: item){
            items[index].name = name
        }
    }
    
}


