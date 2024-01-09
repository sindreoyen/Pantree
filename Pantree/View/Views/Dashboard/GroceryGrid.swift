//
//  GroceryGrid.swift
//  Pantree
//
//  Created by Sindre Øyen on 09/01/2024.
//

import SwiftUI

struct GroceryGrid: View {
    // MARK: - Attributes
    var groceriesFiltered: [[Grocery]]
    @Binding var selectedGrocery: Grocery?
    
    // MARK: - Body
    var body: some View {
        Grid(horizontalSpacing: 15, verticalSpacing: 15) {
            ForEach(groceriesFiltered, id: \.hashValue) { groceries in
                GridRow {
                    ForEach(groceries) { grocery in
                        // Grocery view
                        VStack(alignment: .leading, spacing: 10) {
                            if let imageName = grocery.imageName,
                                let image = UIImage(named: imageName) {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(5)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 80, alignment: .center)
                                    .background(Color.white)
                                    .cornerRadius(5)
                            }
                            Text(grocery.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 15, weight: .semibold))
                            Text("\(grocery.count) remaining")
                                .font(.system(size: 12))
                            if let expiration = grocery.expiration {
                                HStack(spacing: 4) {
                                    Image(systemName: "clock")
                                    Text(expiration)
                                }
                                    .font(.system(size: 12))
                                    .foregroundStyle(grocery.expirationDate ?? Date() + 1000 < Date() ? Color.red : Color.secondary)
                            } else { Spacer() }
                        }
                        .padding(13)
                        .frame(maxWidth: .infinity)
                        .background(DesignConstants.bgGradient)
                        .cornerRadius(5)
                        .shadow(color: .black.opacity(0.1), radius: 5, y: 4)
                        .onTapGesture {
                            DispatchQueue.main.async {
                                selectedGrocery = grocery
                            }
                        }
                    }
                }
            }
        }
    }
}
