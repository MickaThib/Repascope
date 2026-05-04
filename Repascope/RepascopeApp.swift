//
//  RepascopeApp.swift
//  Repascope
//
//  Created by Mickael on 29/04/2026.
//

import SwiftUI
import SwiftData

@main
struct RepascopeApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Guest.self, Ingredient.self, MealIngredient.self, MealItem.self, ShoppingItem.self
        ])
        
        let storeURL = URL.applicationSupportDirectory
                .appendingPathComponent("Repascope")
                .appendingPathComponent("default.store")
            
            // Créer le dossier si nécessaire
            try? FileManager.default.createDirectory(
                at: storeURL.deletingLastPathComponent(),
                withIntermediateDirectories: true
            )
            
        let modelConfiguration = ModelConfiguration(
            "default",
            schema: schema,
            url: storeURL,
            allowsSave: true,
            cloudKitDatabase: .none
        )

            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
          
        // --- DEFAULT CONFIGURTAION --- //
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
        // --- END DEFAULT CONFIGURATION --- //
        
        // ---- UNCOMMENT TO ANALYSE MODEL ERROR ---- //
//        let modelConfiguration = ModelConfiguration(
//            schema: schema,
//            isStoredInMemoryOnly: false,
//            allowsSave: true,
//            groupContainer: .none,
//            cloudKitDatabase: .none
//        )
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            // Ajoute ça temporairement
//            print("Store URL: \(URL.applicationSupportDirectory)")
//            fatalError("Could not create ModelContainer: \(error)")
//        }
        // ---- END UNCOMMENT TO ANALYSE MODEL ERROR ---- //

    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
