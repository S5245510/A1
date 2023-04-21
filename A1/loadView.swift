//
//  loadView.swift
//  A1
//
//  Created by Tsz Hoi Leung on 21/4/2023.
//

import SwiftUI

struct loadView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
            VStack{
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                Text("Loading items")
                    .foregroundColor(.white)
                
            }
        }
    }
}

struct loadView_Previews: PreviewProvider {
    static var previews: some View {
        loadView()
    }
}
