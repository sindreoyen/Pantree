//
//  Tabs.swift
//  Pantree
//
//  Created by Sindre Øyen on 08/01/2024.
//

import Foundation

enum Tab: Int, CaseIterable {
    // MARK: - Cases
    case DASHBOARD = 0
    case SHOPPING_LIST = 1
    
    // MARK: - Properties
    var systemImage: String {
        switch self {
        case .DASHBOARD:
            return "house"
        case .SHOPPING_LIST:
            return "cart"
        }
    }
    
    var title: String {
        switch self {
        case .DASHBOARD:
            return "Dashboard"
        case .SHOPPING_LIST:
            return "Shopping list"
        }
    }
}
