//
//  ShoppingSuggestionWidgetView.swift
//  Pantree
//
//  Created by Sindre Øyen on 08/01/2024.
//

import SwiftUI

struct ShoppingSuggestionWidgetView: View {
    // MARK: - Attributes
    let title: String
    let subtitle: String
    let image: UIImage
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .top) {
            // Left-info
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 15, weight: .medium))
                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundStyle(Color.secondary)
                }
                
                Button {} label: {
                    Label("Add to shopping list", systemImage: "plus")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color.primary)
                        .padding(8)
                        .background(DesignConstants.bgGradient)
                        .cornerRadius(50)
                }
            }
            
            // Image
            Image(uiImage: image)
                .resizable()
                .frame(width: 60, height: 60)
                .aspectRatio(contentMode: .fit)
        }
        .padding(13)
        .background(Color(uiColor: .secondarySystemBackground))
        .cornerRadius(5)
        .shadow(color: .black.opacity(0.1), radius: 5, y: 4)
    }
}
