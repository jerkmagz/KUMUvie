//
//  KUMUvieApp.swift
//  KUMUvie
//
//  Created by Jerk Nino Magdadaro on 10/23/21.
//

import SwiftUI

@main
struct KUMUvieApp: App {
    // Initialize PersistenceController
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MovieListView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext) // Inject Core Data managedObjectContext to the Environment
        }
    }
}
