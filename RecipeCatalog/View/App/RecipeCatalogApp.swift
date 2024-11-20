//
//  RecipeCatalogApp.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/12/24.
//

import SwiftUI
import SwiftData

@main
struct RecipeCatalogApp: App {
    let container: ModelContainer
    let viewModel: RecipeViewModel
    
    var body: some Scene {
        WindowGroup {
            AppView()
        }
        .modelContainer(container)
        .environment(viewModel)
    }
    
    init() {
        do {
            container = try ModelContainer(for: Recipe.self)
        } catch {
            fatalError(
                """
                    Failed to create ModelContainer for Recipe. If you made
                    a change to the Model, then uninstall the app and restart 
                    it form Xcode.
                """
            )
        }
        
        viewModel = RecipeViewModel(container.mainContext)
    }
}
