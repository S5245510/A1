//
//  ChecklistViewModel.swift
//  A1
//
//  Created by Tsz Hoi Leung on 02/04/2023.
//
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
    }
        
    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    func editItem(item: ChecklistItem, name: String) {
        if let index = items.firstIndex(of: item) {
            items[index].name = name
        }
    }
    
    func editDetail(item: ChecklistItem, detail: String) {
        if let index = items.firstIndex(of: item) {
            items[index].detail = detail
        }
    }
}


