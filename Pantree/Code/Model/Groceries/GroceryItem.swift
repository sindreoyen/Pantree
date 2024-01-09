//
//  GroceryItem.swift
//  Pantree
//
//  Created by Sindre Øyen on 07/01/2024.
//

import Foundation

struct GroceryItem: Identifiable, Codable, Hashable {
    // MARK: - Attributes
    private(set) var id = UUID()
    
    var typeName: String?
    var count: Int
    
    var registerDate: Date? = Date()
    var expiryDate: Date?
    
    var expired: Bool {
        guard let expiryDate else { return false }
        return expiryDate < Date()
    }
}

extension Date {
    func dateString(_ dateStyle: DateFormatter.Style, _ timeStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }
}
