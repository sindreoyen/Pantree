//
//  CustomSegmentedControl.swift
//  Pantree
//
//  Created by Sindre Øyen on 08/01/2024.
//

import SwiftUI


struct CustomSegmentedControl: View {
    // MARK: Attributes
    @Binding var selectedIndex: Int
    var options: [String]
    @Namespace private var animation
    
    // MARK: Body
    var body: some View {
        HStack(spacing: 0) {
            ForEach(options.indices, id:\.self) { index in
                let isSelected = selectedIndex == index
                ZStack {
                    Rectangle()
                        .fill(Color.secondary.opacity(0.3))
                    
                    if isSelected {
                        Rectangle()
                            .fill(DesignConstants.bgGradient)
                            .cornerRadius(5)
                            .padding(2)
                            .matchedGeometryEffect(id: "customsegment", in: animation)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        selectedIndex = index
                    }
                }
                .overlay(
                    Text(options[index])
                        .font(.system(size: 13))
                        .fontWeight(isSelected ? .bold : .regular)
                        .foregroundColor(.primary)
                )
            }
        }
        .frame(height: 40)
        .cornerRadius(8)
    }
}
