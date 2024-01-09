//
//  PantryType.swift
//  Pantree
//
//  Created by Sindre Øyen on 08/01/2024.
//

import Foundation

enum PantryType: Int, CaseIterable, Hashable, Codable {
    case FRIDGE = 0
    case FREEZER = 1
    
    var name: String {
        switch self {
        case .FRIDGE:
            return "Fridge"
        case .FREEZER:
            return "Freezer"
        }
    }
}
