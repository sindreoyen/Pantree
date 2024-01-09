//
//  Grocery.swift
//  Pantree
//
//  Created by Sindre Øyen on 07/01/2024.
//

import Foundation
import SwiftData
import UIKit

/**
 The superclass for a given grocery, it contains all the instances of a specific grocery.
 */
@Model
final class Grocery {
    // MARK: - Attributes
    @Attribute(.unique) var name: String
    @Attribute(.externalStorage) var imageName: String?
    var pantry: PantryType
    private(set) var items: [GroceryItem]
    
    // MARK: - Init
    init(name: String, imageName: String? = nil, items: [GroceryItem], pantry: PantryType) {
        self.name = name
        self.items = items
        self.pantry = pantry
        self.imageName = imageName
    }
    
    // MARK: - Methods
    var count: Int {
        return items.reduce(0, { $0 + $1.count })
    }
    
    var expirationDate: Date? {
        return items.compactMap({ $0.expiryDate }).min()
    }
    var expiration: String? {
        guard let expiration = expirationDate else { return nil }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: expiration)
    }
    
    func remove(_ item: GroceryItem) {
        self.items.removeAll(where: { $0.id == item.id })
    }
}
