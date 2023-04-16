//
//  ItemDetailView.swift
//  A1
//


import SwiftUI

struct ItemDetailView: View {
    @ObservedObject var viewModel: ChecklistViewModel
    @State var isEditMode = false
    @State var editTitle = ""
    
    
    var body: some View {
        NavigationView {
            List{
                VStack {
                    Text(viewModel.items.name)
                        .font(.title)
                    
                    Spacer()
                }
                VStack(alignment: .leading) {
                    Text("Item Detail")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                }
                //.onDelete(perform: viewModel.deleteItems)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    if isEditMode {
                        TextField("Edit title here", text:viewModel.items.name) //$editTitle)
                            .font(.headline)
                            .bold()
                            .foregroundColor(.red)
                    }
                        else {
                            Text(viewModel.items.name)       .font(.headline)
                                .foregroundColor(.primary)
                        }
                    
                }
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
}


struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(viewModel: ChecklistViewModel(),
                       item: ChecklistItem(name: "Item 1", isChecked: false,detail: "item details"))
    }
}
