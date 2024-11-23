//
//  RecipeViewModel.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/19/24.
//

import Foundation
import SwiftData

@Observable class RecipeViewModel {
    // MARK: - Properties
    
    private var modelContext: ModelContext
    
    // MARK: - Initialization
    
    init(_ modelContext: ModelContext) {
        self.modelContext = modelContext
        DataPreloader.preloadData(with: modelContext)
        fetchData()
    }
    
    // MARK: - Model Access
    
    private(set) var categories: [Category] = []
    private(set) var specialCategories: [Category] = []
    private(set) var favorites: [Recipe] = []
    private(set) var recipes: [Recipe] = []
    // Search by keyword
    
    // MARK: - Model Functions
    
    func fetchData() {
        try? modelContext.save()
        
        do {
            let recipeDescriptor = FetchDescriptor<Recipe>(sortBy: [SortDescriptor(\.title)])
            let categoryDescriptor = FetchDescriptor<Category>(
                predicate: #Predicate { !$0.specialCategory },
                sortBy: [SortDescriptor(\.title)]
            )
            let specialCategoryDescriptor = FetchDescriptor<Category>(
                predicate: #Predicate { $0.specialCategory },
                sortBy: [SortDescriptor(\.title)]
            )
            let favoritesDescriptor = FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.isFavorite },
                sortBy: [SortDescriptor(\.title)]
            )
            
            recipes = try modelContext.fetch(recipeDescriptor)
            categories = try modelContext.fetch(categoryDescriptor)
            specialCategories = try modelContext.fetch(specialCategoryDescriptor)
            favorites = try modelContext.fetch(favoritesDescriptor)
            
            updateSpecialCategories()
            
//            print("Fetched Recipes:")
//            recipes.forEach {
//                print($0)
//                print("")
//            }
//
//            print("Fetched Categories:")
//            categories.forEach {
//                print($0)
//                print("")
//            }
//            print("")
//
//            print("Fetched Favorites:")
//            print(favorites)

        } catch {
            print("Failed to load recipes")
        }
    }
    
    // MARK: - Helper Functions
    
    func updateSpecialCategories() {
        if let allRecipesCategory = specialCategories.first(where: { $0.title == "All Recipes" }) {
            allRecipesCategory.recipes = recipes
        }

        if let favoritesCategory = specialCategories.first(where: { $0.title == "Favorites" }) {
            favoritesCategory.recipes = favorites
        }
    }
}
