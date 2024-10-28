//
//  To_DoListApp.swift
//  To-DoList
//
//  Created by Roman Khancha on 11.10.2024.
//

import SwiftUI
import SwiftData

@main
struct To_DoListApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Task.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            TaskListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
