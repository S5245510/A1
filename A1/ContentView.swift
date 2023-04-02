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
    ["Item 3", " "],
    [ "Item 4"," "]
]


struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Text("CheckList")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                ForEach(items, id:\.self){ item in
                    HStack {
                        Text(item[0])
                        .font(.title2)
                        .fontWeight(.semibold)
                        Spacer()
                        Image(systemName:item[1])
                        .foregroundColor(.green)
                    }
                    .padding([.top, .leading])
                    
                }
            }
            .listStyle(.plain)
            .navigationTitle("Checklist")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
