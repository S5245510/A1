//
//  ContentView.swift
//  A1
//
//  Created by Tsz Hoi Leung on 20/3/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ChecklistViewModel()
    @State var isEditMode = false
    @State var checklistTitle = "Today routine"
    @State var editTitle = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items.indices) { index in
                    let item = viewModel.items[index]
                    NavigationLink(
                        destination: ItemDetailView(viewModel: viewModel, item: viewModel.items[index])) {
                        HStack {
                            if isEditMode{
                                TextField("Item Name", text: $viewModel.items[index].name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Toggle("", isOn: $viewModel.items[index].isChecked)
                                                        .labelsHidden()                            }else {
                                Text(item.name)
                                Spacer()
                                Image(systemName: item.isChecked ? "checkmark" : "")
                            }
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteItems)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    if isEditMode {
                        TextField("Edit title here", text: $editTitle)
                            .font(.headline)
                            .bold()
                            .foregroundColor(.red)
                    }else {
                        if !editTitle.isEmpty{
                            Text(editTitle)
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                        }
                        else {
                            Text(checklistTitle)       .font(.headline)
                                .foregroundColor(.primary)
                        }
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: { isEditMode.toggle() }) {
                        Text(isEditMode ? "Done" : "Edit")
                    }
                    Button(action:{
                        let newItem = ChecklistItem(name: "New routine", isChecked: false, detail: "routine detail")
                        viewModel.addItem(newItem)
                    }){
                    Image(systemName: "plus")
                    }
                }
            }
            .environment(\.editMode, isEditMode ? .constant(.active) : .constant(.inactive))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
