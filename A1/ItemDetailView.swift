//
//  ItemDetailView.swift
//  A1
//


import SwiftUI

struct ItemDetailView: View {
    @ObservedObject var viewModel: ChecklistViewModel
    let item: ChecklistItem
    @State var isEditMode = false
    
    
    var body: some View {
        List{
            VStack {
                Text(item.name)
                    .font(.title)
                    
                Spacer()
            }
            VStack(alignment: .leading) {
                Text("Item Detail")
                    .font(.headline)
                    .fontWeight(.bold)
                
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: { isEditMode.toggle() }) {
                    Text(isEditMode ? "Done" : "Edit")
                }
                Button(action: viewModel.addItem) {
                    Image(systemName: "plus")
                }
            }
        }
        .environment(\.editMode, isEditMode ? .constant(.active) : .constant(.inactive))
        }

    }


struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(viewModel: ChecklistViewModel(),
                       item: ChecklistItem(name: "Item 1", isChecked: false))
    }
}
