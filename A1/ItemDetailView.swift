//
//  ItemDetailView.swift
//  A1
//
//  Created by Tsz Hoi Leung on 02/04/2023.
//


import SwiftUI

struct ItemDetailView: View {
    @ObservedObject var viewModel: ChecklistViewModel
    let item: ChecklistItem

    
    @State private var isEditMode = false
    @State private var itemName = ""
    @State private var itemDetails = ""
    
    
    init(viewModel: ChecklistViewModel, item: ChecklistItem) {
        self.viewModel = viewModel
        self.item = item
        self._itemName = State(initialValue: item.name)
        self._itemDetails = State(initialValue: item.detail)
    }
    
    var body: some View {
        // some formatting to show title in middle
        VStack(alignment: .center, spacing: 20) {
            // show different displays according to edit mode
            if isEditMode{
                TextField("Item Name", text: $itemName)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .bold()
                    .foregroundColor(.red)
                Divider()
                TextField("Item Details", text: $itemDetails)
                    .font(.headline)
                    .foregroundColor(.red)
                    .padding(.horizontal)
                Text("Edit mode is on, Please select details and title to edit")
                    .foregroundColor(.gray)
                
                Spacer()
                
            }else{
                Text(item.name)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .bold()
                Divider()
                VStack(alignment: .leading){
                    Text(item.detail)
                        .font(.headline)
                        .padding(.horizontal)
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
        }
        .navigationTitle(item.name)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    // edit mode button
                    isEditMode.toggle()
                }) {
                    Text(isEditMode ? "Done" : "Edit")
                }
            }
        }
        // pass all the updated value to items by using defined funcs
        .onChange(of: isEditMode) { value in
            if !value {
                viewModel.editItems(item: item, name: itemName)
                viewModel.editDetails(item: item, detail: itemDetails)
            }
        }
    }
}



struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(viewModel: ChecklistViewModel(),
                       item: ChecklistItem(name: "Item 1", isChecked: false,detail: "item details"))
    }
}
