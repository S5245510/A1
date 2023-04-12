//
//  ItemDetailView.swift
//  A1
//


import SwiftUI

struct ItemDetailView: View {
    @ObservedObject var viewModel: ChecklistViewModel
    let item: ChecklistItem
    
    @State private var isShowingEditView = false
    
    var body: some View {
        VStack {
            Text(item.name)
                .font(.title)
            Spacer()
            Text("Status: \(item.isChecked ? "Checked" : "Unchecked")")
            Spacer()
        }
        Text("Item Detail")
            .font(.headline)
            .fontWeight(.bold)
        .toolbar {
            ToolbarItemGroup() {
                Button(action: { isShowingEditView.toggle() }) {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $isShowingEditView) {
            EditItemView(viewModel: viewModel, item: item)
        }
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(viewModel: ChecklistViewModel(),
                       item: ChecklistItem(name: "Item 1", isChecked: false))
    }
}
