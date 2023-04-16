//
//  ChecklistItem.swift
//  A1
//
//  Created by Tsz Hoi Leung on 12/4/2023.
//

import Foundation


struct ChecklistItem : Identifiable, Equatable{
    let id = UUID()
    var name: String
    var isChecked: Bool = false
    var detail: String
}
