//
//  ContentView.swift
//  A1
//
//  Created by Tsz Hoi Leung on 20/3/2023.
//

import SwiftUI

struct ContentView: View {
    // define that this view use the logic in ChecklistViewModel as viewModel
    @ObservedObject var viewModel = ChecklistViewModel()
   // set the default view is not editMode
    @State var isEditMode = false
    @State var checklistTitle = "Today routine"
    @State var editTitle = ""
    
    var body: some View {
        NavigationView {
            List {
                // use ForEach to display all the items in array
                ForEach(viewModel.items, id: \.id) { item in
                    NavigationLink(
                        // pass the view to the corresponding item detail view
                        destination: ItemDetailView(viewModel: viewModel, item: item)) {
                        HStack {
                            //Checklist item can be editted when edit mode is on
                            if isEditMode{
                                TextField("Item Name", text: $viewModel.items[viewModel.items.firstIndex(of: item)!].name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                // checkmark status can be edited
                                Toggle("", isOn: $viewModel.items[viewModel.items.firstIndex(of: item)!].isChecked)
                                .labelsHidden()
                            }else {
                                // when edit mode off
                                Text(item.name)
                                Spacer()
                                Image(systemName: item.isChecked ? "checkmark" : "")
                            }
                        }
                    }
                }
                // delete items
                .onDelete(perform: viewModel.deleteItems)
                // re-ordering items
                .onMove(perform: viewModel.moveItems)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    // to change the title of the checklist aacording to the edit mode
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
                            Text(checklistTitle)
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    // Reset, add items and Edit mode buttons
                    if isEditMode {
                        Button(action: {viewModel.resetCheck()}) {
                            Text("Reset")
                        }
                    }
                    Button(action:{
                        viewModel.addItems()
                    }){
                        Image(systemName: "plus")
                    }
                    Button(action: { isEditMode.toggle() }) {
                    Text(isEditMode ? "Done" : "Edit")
                    
                    }
                }
            }
            // to set edit mode environment variable
            .environment(\.editMode, isEditMode ? .constant(.active) : .constant(.inactive))
        }
        // will load items every time this view present
        .onAppear {
            viewModel.loadItems()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
