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
                ForEach(viewModel.items, id: \.id) { item in
                    NavigationLink(
                        destination: ItemDetailView(viewModel: viewModel, item: item)) {
                        HStack {
                            if isEditMode{
                                TextField("Item Name", text: $viewModel.items[viewModel.items.firstIndex(of: item)!].name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Toggle("", isOn: $viewModel.items[viewModel.items.firstIndex(of: item)!].isChecked)
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
                        viewModel.addItem()
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
