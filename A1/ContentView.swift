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
    @State var checklistTitle = "Checklist"
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items) { item in
                    NavigationLink(
                        destination: ItemDetailView(viewModel: viewModel, item: item)) {
                        HStack {
                            Text(item.name)
                            Spacer()
                            Image(systemName: item.isChecked ? "checkmark" : "")
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteItems)
            }
            .navigationTitle(Text(checklistTitle))
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    if isEditMode {
                        TextField("Edit title here", text: $checklistTitle).textFieldStyle(isEditMode?.wrappedValue == .active ? PlainTextFieldStyle() : RoundedBorderTextFieldStyle())
                            .font(.headline)
                            .foregroundColor(.primary)
                    } else {
                        Text(checklistTitle)
                            .font(.headline)
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
