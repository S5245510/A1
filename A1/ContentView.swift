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
            .navigationTitle(Text("Checklist"))
            .toolbar {
                ToolbarItemGroup(placement: .automatic) {
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
