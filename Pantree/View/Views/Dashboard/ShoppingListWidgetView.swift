//
//  ShoppingListWidgetView.swift
//  Pantree
//
//  Created by Sindre Øyen on 08/01/2024.
//

import SwiftUI

struct ShoppingListWidgetView: View {
    // MARK: - Attributes
    @EnvironmentObject private var tabHandler: TabHandler
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 10) {
            // Title
            HStack(alignment: .center) {
                Text("Your shopping list")
                    .font(.system(size: 16, weight: .medium))
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 15, weight: .medium))
            }
            
            // Info
            HStack(alignment: .center) {
                Text("14 items")
                    .font(.system(size: 12, weight: .regular))
                Spacer()
                
            }
        }
        .padding(13)
        .background(DesignConstants.bgGradient)
        .cornerRadius(5)
        .shadow(color: .black.opacity(0.1), radius: 5, y: 4)
        .onTapGesture {
            tabHandler.navigate(to: .SHOPPING_LIST)
        }
    }
}

#Preview {
    ShoppingListWidgetView()
}
