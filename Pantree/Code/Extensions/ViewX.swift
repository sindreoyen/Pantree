//
//  ViewX.swift
//  Pantree
//
//  Created by Sindre Øyen on 09/01/2024.
//

import SwiftUI

// MARK: - View extensions
extension View {
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

// MARK: - Helping structs
struct RoundedCorner: Shape {
    // MARK: - Attributes
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    // MARK: - Methods
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
