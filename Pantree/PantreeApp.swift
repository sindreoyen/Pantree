//
//  PantreeApp.swift
//  Pantree
//
//  Created by Sindre Øyen on 07/01/2024.
//

import SwiftUI
import SwiftData

@main
struct PantreeApp: App {
    // MARK: - Attributes
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Grocery.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    // MARK: - Body
    var body: some Scene {
        // Creating window group with environment ModelContainer
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
