//
//  SearchBarView.swift
//  Pantree
//
//  Created by Sindre Øyen on 08/01/2024.
//

import SwiftUI

struct SearchBarView: View {
    // MARK: - Attributes
    var placeholder: String = "Search..."
    @Binding var text: String
    @State private var isEditing = false
    
    var shouldShowCancel: Bool = true
    
    // MARK: - Body
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .font(.system(size: 14))
                .padding(8)
                .padding(.horizontal, 25)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(Color.secondary)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if text.count > 0 {
                            Button(action: {
                                text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .onTapGesture {
                    withAnimation {
                        self.isEditing = true
                    }
                }
            
            if isEditing && shouldShowCancel {
                Button(action: {
                    self.isEditing = false
                    text = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
        }
    }
}
