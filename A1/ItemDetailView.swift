//
//  ItemDetailView.swift
//  A1
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
        VStack(alignment: .center, spacing: 20) {
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
                    isEditMode.toggle()
                }) {
                    Text(isEditMode ? "Done" : "Edit")
                }
            }
        }
        .onChange(of: isEditMode) { value in
            if !value {
                viewModel.editItem(item: item, name: itemName)
                viewModel.editDetail(item: item, detail: itemDetails)
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
