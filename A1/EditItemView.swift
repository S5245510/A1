//
//  EditItemView.swift
//  A1
//


import SwiftUI


struct EditItemView: View {
    @ObservedObject var viewModel: ChecklistViewModel
    @Environment(\.presentationMode) var presentationMode
    
    let item: ChecklistItem
    
    @State private var name: String
    
    init(viewModel: ChecklistViewModel, item: ChecklistItem) {
        self.viewModel = viewModel
        self.item = item
        self._name = State(initialValue: item.name)
    }
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: { updateItem() }) {
                Text("Save")
            }
        }
        .padding()
        Text("Edit Item")
    }
    
    private func updateItem() {
        viewModel.editItem(item: item, name: name)
        presentationMode.wrappedValue.dismiss()
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ChecklistViewModel()
        let item = ChecklistItem(name: "Test Item", detail:"item details")
        EditItemView(viewModel: viewModel, item: item)
    }
}
