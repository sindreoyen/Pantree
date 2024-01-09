//
//  Dashboard.swift
//  Pantree
//
//  Created by Sindre Øyen on 07/01/2024.
//

import SwiftUI
import SwiftData

struct DashboardScreen: View {
    // MARK: - Attributes
    // Environment
    @Environment(\.modelContext) private var modelContext
    // State
    @State fileprivate var selectedPantry: Int = 0
    @State var searchText: String = ""
    @State var selectedGrocery: Grocery?
    // SwiftData
    @Query var groceries: [Grocery]
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // MARK: Header info and widgets
                VStack(alignment: .leading, spacing: 15) {
                    // Header-text
                    Text("Welcome to your home, Javier!")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 20, weight: .semibold))
                    
                    // Notification
                    if let image = UIImage(named: "cartoon-cheese-1") {
                        ShoppingSuggestionWidgetView(title: "Your cheese expired yesterday", subtitle: "We can remind you to buy a new one!", image: image)
                    }
                    
                    // Shopping list widget
                    ShoppingListWidgetView()
                }
                
                // MARK: Toggles and search between fridge and freezer
                VStack(alignment: .leading, spacing: 15) {
                    Text("What's in stock?")
                        .font(.system(size: 20, weight: .semibold))
                    
                    CustomSegmentedControl(selectedIndex: $selectedPantry, options: ["My fridge", "My freezer"])
                    
                    SearchBarView(placeholder: "Search your \(PantryType(rawValue: selectedPantry)!.name.lowercased())...", text: $searchText)
                }
                
                // MARK: Grid with groceries
                if let groceriesFiltered {
                    GroceryGrid(groceriesFiltered: groceriesFiltered, selectedGrocery: $selectedGrocery)
                }
            }
            .padding(20)
        }
        .refreshable {
            // Fridge
            let apple = Grocery(name: "Apple", imageName: "apple", items: [.init(count: 2), .init(count: 3)], pantry: .FRIDGE)
            let milk = Grocery(name: "Milk", imageName: "milk", items: [.init(count: 3, expiryDate: Date() + 86400 * 4), .init(count: 1, expiryDate: Date() + 86400 * 10)], pantry: .FRIDGE)
            let cheese = Grocery(name: "Cheese", imageName: "cartoon-cheese-1", items: [.init(count: 1, expiryDate: Date() - 86400)], pantry: .FRIDGE)
            let pear = Grocery(name: "Pear", imageName: "pear", items: [.init(count: 2)], pantry: .FRIDGE)
            
            // Freezer
            let pizza = Grocery(name: "Pizza", imageName: "pizza", items: [.init(typeName: "Grandiosa", count: 3)], pantry: .FREEZER)
            let peas = Grocery(name: "Peas", imageName: "peas", items: [.init(count: 2)], pantry: .FREEZER)
            
            // Insert
            withAnimation(.easeInOut(duration: 0.1)) {
                modelContext.insert(apple)
                modelContext.insert(milk)
                modelContext.insert(cheese)
                modelContext.insert(pear)
                
                modelContext.insert(pizza)
                modelContext.insert(peas)
            }
        }
        .sheet(item: $selectedGrocery) { grocery in
            GroceryDetail(grocery: grocery)
        }
    }
    
    var groceriesFiltered: [[Grocery]]? {
        let val = groceries.filter {
            $0.count > 0 &&
            $0.pantry.rawValue == selectedPantry &&
            (searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased()))
        }
        if val.isEmpty { return nil }
        var groceryArr: [[Grocery]] = []
        for i in stride(from: 0, through: val.count, by: 2) {
            if i >= val.count { break }
            var arr: [Grocery] = []
            arr.append(val[i])
            if i + 1 >= val.count { groceryArr.append(arr); break }
            arr.append(val[i + 1])
            groceryArr.append(arr)
        }
        return groceryArr
    }
}

#Preview {
    DashboardScreen()
        .modelContainer(for: Grocery.self, inMemory: true)
}
