//
//  DesignConstants.swift
//  Pantree
//
//  Created by Sindre Øyen on 07/01/2024.
//

import SwiftUI

class DesignConstants {
    // MARK: - Colors
    /// The gradient used for call-to-action background colors, such as buttons etc .
    static let bgGradient: LinearGradient = .init(colors: [
        Color(uiColor: .init(red: 0.51, green: 0.80, blue: 0.00, alpha: 1.00)),
        Color(uiColor: .init(red: 0.75, green: 0.90, blue: 0.00, alpha: 1.00))
    ], startPoint: .leading, endPoint: .trailing)
}
