//
//  GroceryDetail.swift
//  Pantree
//
//  Created by Sindre Øyen on 08/01/2024.
//

import SwiftUI
import SwiftData
import ColorThiefSwift

struct GroceryDetail: View {
    // MARK: - Attributes
    let grocery: Grocery
    @State var image: UIImage?
    @State var customGradient: LinearGradient?
    
    // MARK: - Init
    init(grocery: Grocery) {
        self.grocery = grocery
        if let imageName = grocery.imageName, let image = UIImage(named: imageName) {
            self._image = State(initialValue: image)
            if let avgColor = ColorThief.getColor(from: image)?.makeUIColor() {
                let color2 = avgColor.lighter(componentDelta: 0.2)
                self._customGradient = State(initialValue: LinearGradient(colors: [.init(uiColor: avgColor), .init(uiColor: color2)], startPoint: .leading, endPoint: .trailing))
            }
        }
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140, height: 140)
                        .shadow(color: .white.opacity(0.4), radius: 40)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 200, alignment: .center)
            .background(customGradient ?? DesignConstants.bgGradient)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            
            Spacer().frame(height: 15)
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    // Grocery title
                    Text(grocery.name)
                        .font(.system(size: 25, weight: .semibold))
                    // Which pantry
                    Label("In your \(grocery.pantry.name.lowercased())", systemImage: "info.circle")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.secondary)
                        .padding(5)
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(50)
                }
                
                Divider()
                Text("In stock")
                    .font(.system(size: 15, weight: .medium))
                
                // Stock
                ForEach(grocery.items) { item in
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("\(item.count) unit\(item.count > 1 ? "s" : "")")
                                .font(.system(size: 15, weight: .semibold))
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Label("\(item.expiryDate?.dateString(.medium, .none) ?? "No expiration registered")", systemImage: "clock")
                                    .foregroundStyle(item.expired ? .red : .secondary)
                                Text("Added \(item.registerDate?.dateString(.medium, .none) ?? "")")
                            }
                                .font(.system(size: 12))
                                .foregroundStyle(Color.secondary)
                        }
                        Spacer()
                        
                        Button {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                grocery.remove(item)
                            }
                        } label: {
                            Text("Delete")
                                .font(.system(size: 15, weight: .medium))
                                .padding(7)
                                .background(Color.red)
                                .foregroundStyle(Color.white)
                                .cornerRadius(5)
                        }
                    }
                    .padding(13)
                    .frame(maxWidth: .infinity)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(5)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}
