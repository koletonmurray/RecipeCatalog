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
    private(set) var recipes: [Recipe] = []
    
    // MARK: - Model Functions
    
    func fetchData() {
        try? modelContext.save()
        specialCategories = fetchSpecialCategories()
        recipes = fetchAllRecipes()
        
        updateAllRecipes()
        updateFavoriteRecipes()
        
        categories = fetchRegularCategories()
    }
    
    // MARK: - User Intents
    
    func toggleFavorite(for recipe: Recipe) {
        recipe.isFavorite.toggle()
        updateFavoriteRecipes()
    }
    
    // MARK: - Helper Functions
    
    func fetchAllRecipes() -> [Recipe] {
        do {
            let descriptorAllRecipes = FetchDescriptor<Recipe>(
                sortBy: [SortDescriptor(\.title)]
            )
            return try modelContext.fetch(descriptorAllRecipes)
        } catch {
            print("Failed to fetch all recipes: \(error)")
            return []
        }
    }
    
    func fetchFavoriteRecipes() -> [Recipe] {
        do {
            let descriptorFavoriteRecipes = FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.isFavorite },
                sortBy: [SortDescriptor(\.title)]
            )
            return try modelContext.fetch(descriptorFavoriteRecipes)
        } catch {
            print("Failed to fetch favorites: \(error)")
            return []
        }
    }
    
    func fetchRegularCategories() -> [Category] {
        do {
            let descriptorRegularCategories = FetchDescriptor<Category>(
                predicate: #Predicate { !$0.specialCategory },
                sortBy: [SortDescriptor(\.title)]
            )
            return try modelContext.fetch(descriptorRegularCategories)
        } catch {
            print("Failed to fetch regular categories: \(error)")
            return []
        }
    }
    
    func fetchSpecialCategories() -> [Category] {
        do {
            let descriptorSpecialCategories = FetchDescriptor<Category>(
                predicate: #Predicate { $0.specialCategory },
                sortBy: [SortDescriptor(\.title)]
            )
            return try modelContext.fetch(descriptorSpecialCategories)
        } catch {
            print("Failed to fetch special categories: \(error)")
            return []
        }
    }
    
    func updateAllRecipes() {
        if let allRecipesCategory = specialCategories.first(where: { $0.title == RecipeAppConstants.recipesKey }) {
            allRecipesCategory.recipes = recipes
        }
    }

    func updateFavoriteRecipes() {
        if let favoritesCategory = specialCategories.first(where: { $0.title == RecipeAppConstants.favoritesKey }) {
            favoritesCategory.recipes = fetchFavoriteRecipes()
        }
    }
}
