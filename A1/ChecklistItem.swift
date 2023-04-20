//
//  ChecklistItem.swift
//  A1
//
//  Created by Tsz Hoi Leung on 02/04/2023.
//

import Foundation

struct ChecklistItem : Identifiable, Equatable, Codable {
    var id = UUID()
    var name: String
    var isChecked: Bool = false
    var detail: String
}
