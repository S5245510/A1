//
//  ContentView.swift
//  A1
//
//  Created by Tsz Hoi Leung on 20/3/2023.
//

import SwiftUI

let items = [
    ["Item 1", "checkmark"],
    [ "Item 2", "checkmark"],
    ["Item 3", ""],
    [ "Item 4",""]
]

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(items, id:\.self){ item in
                    HStack {
                        Text(item[0])
                        Spacer()
                        Image(systemName:item[1])
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Checklist")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
