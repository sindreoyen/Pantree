//
//  ContentView.swift
//  Pantree
//
//  Created by Sindre Øyen on 07/01/2024.
//

import SwiftUI
import SwiftData

class TabHandler: ObservableObject {
    @Published var selectedTab: Int = 0
    
    func isSelected(_ tab: Tab) -> Bool {
        return tab.rawValue == selectedTab
    }
    func navigate(to tab: Tab) {
        DispatchQueue.main.async {
            withAnimation(.easeInOut(duration: 0.1)) {
                self.selectedTab = tab.rawValue
            }
        }
    }
}

struct ContentView: View {
    // MARK: - Attributes
    @StateObject private var tabHandler = TabHandler()
    
    // MARK: - Init
    init() {
        let transparentAppearence = UITabBarAppearance()
        transparentAppearence.configureWithTransparentBackground() // 🔑
        UITabBar.appearance().standardAppearance = transparentAppearence
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom) {
            // MARK: Screens
            TabView(selection: $tabHandler.selectedTab) {
                DashboardScreen().tag(0)
                
                ShoppingListScreen().tag(1)
            }
            .environmentObject(tabHandler)
            
            // MARK: TabBar
            VStack {
                HStack(alignment: .center, spacing: 15) {
                    // Dashboard
                    Spacer()
                    tabItemView(tab: .DASHBOARD)
                    // Plus sign
                    Spacer()
                    Button { } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 40, weight: .medium))
                            .tint(.black)
                    }
                    // Shopping list
                    Spacer()
                    tabItemView(tab: .SHOPPING_LIST)
                    // End
                    Spacer()
                }
                Spacer()
            }
            .padding(20)
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .background(ignoresSafeAreaEdges: .bottom)
            .roundedCorner(25, corners: [.topLeft, .topRight])
            .shadow(color: .black.opacity(0.05), radius: 10, y: -3)
        }
        .toolbar(.hidden, for: .tabBar)
        .ignoresSafeArea(edges: .bottom)
    }
    
    func tabItemView(tab: Tab) -> some View {
        Button {
            tabHandler.navigate(to: tab)
        } label: {
            VStack(alignment: .center) {
                Image(systemName: "\(tab.systemImage)\(tabHandler.selectedTab == tab.rawValue ? ".fill" : "")")
                    .font(.system(size: 22, weight: .medium))
            }
        }
        .tint(tabHandler.isSelected(tab) ? .green : .secondary)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Grocery.self, inMemory: true)
}
