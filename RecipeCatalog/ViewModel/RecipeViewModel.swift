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
    
    private(set) var recipes: [Recipe] = []
    private(set) var categories: [Category] = []
    private(set) var specialCategories: [Category] = []
    
    // MARK: - Model Functions
    
    func fetchData() {
        try? modelContext.save()
        specialCategories = fetchSpecialCategories()
        
        updateCategoryAllRecipes()
        updateCategoryFavoriteRecipes()
        updateCategories()
        updateAllRecipes()
    }
    
    // MARK: - User Intents
    
    func addRecipeToCategory(recipe: Recipe, category: Category) {
        category.recipes.append(recipe)
        recipe.categories.append(category)
        
        do {
            try modelContext.save()
            print("Recipe successfully added to category!")
            
            updateCategories()
            updateAllRecipes()
        } catch {
            print("Failed to add recipe to category: \(error)")
        }
    }
    
    func createCategory(
        categoryTitle: String
    ) {
        let newCategory = Category(
            title: categoryTitle
        )
        
        modelContext.insert(newCategory)
        
        do {
            try modelContext.save()
            print("Category successfully created!")
        } catch {
            print("Failed to save category: \(error)")
        }
        
        updateCategories()
    }
    
    func createRecipe(
        recipeName: String,
        author: String,
        cookTime: Int,
        servings: Int,
        difficulty: Int,
        calories: Int,
        ingredients: String,
        instructions: String,
        additionalNotes: String,
        isFavorite: Bool
    ) {
        let newRecipe = Recipe(
            title: recipeName,
            author: author,
            dateAdded: Date(),
            minutesToCook: cookTime,
            servings: servings,
            difficulty: difficulty,
            caloriesPerServing: calories,
            ingredients: ingredients,
            instructions: instructions,
            additionalNotes: additionalNotes,
            isFavorite: isFavorite
        )
        
        modelContext.insert(newRecipe)
        
        do {
            try modelContext.save()
            print("Recipe successfully created!")
        } catch {
            print("Failed to save recipe: \(error)")
        }
        
        updateCategoryAllRecipes()
        updateCategoryFavoriteRecipes()
        updateAllRecipes()
    }
    
    func deleteCategory(category: Category) {
        modelContext.delete(category)
        
        do {
            try modelContext.save()
            print("Category successfully deleted!")
            
            updateCategories()
        } catch {
            print("Failed to delete category: \(error)")
        }
    }
    
    func deleteRecipe(recipe: Recipe) {
        modelContext.delete(recipe)
        
        do {
            try modelContext.save()
            print("Recipe successfully deleted!")
            
            updateCategoryAllRecipes()
            updateCategoryFavoriteRecipes()
            updateAllRecipes()
        } catch {
            print("Failed to delete recipe: \(error)")
        }
    }
    
    func removeRecipeFromCategory(recipe: Recipe, category: Category) {
        if let recipeIndex = category.recipes.firstIndex(of: recipe) {
            category.recipes.remove(at: recipeIndex)
        }
        if let categoryIndex = recipe.categories.firstIndex(of: category) {
            recipe.categories.remove(at: categoryIndex)
        }
            
        do {
            try modelContext.save()
            print("Recipe successfully removed from category!")
            
            updateAllRecipes()
            updateCategories()
        } catch {
            print("Failed to remove recipe from category: \(error)")
        }
    }
    
    func toggleFavorite(for recipe: Recipe) {
        recipe.isFavorite.toggle()
        updateCategoryFavoriteRecipes()
        updateAllRecipes()
    }
    
    func updateCategory(
        existingCategory: Category?,
        categoryTitle: String
    ) {
        if let existingCategory {
            existingCategory.title = categoryTitle
            
            do {
                try modelContext.save()
                print("Category successfully updated!")
            } catch {
                print("Failed to update category: \(error)")
            }
            
            updateCategories()
        }
    }
    
    func updateRecipe(
        existingRecipe: Recipe?,
        recipeName: String,
        author: String,
        cookTime: Int,
        servings: Int,
        difficulty: Int,
        calories: Int,
        ingredients: String,
        instructions: String,
        additionalNotes: String,
        isFavorite: Bool
    ) {
        if let existingRecipe {
            existingRecipe.title = recipeName
            existingRecipe.author = author
            existingRecipe.minutesToCook = cookTime
            existingRecipe.servings = servings
            existingRecipe.difficulty = difficulty
            existingRecipe.caloriesPerServing = calories
            existingRecipe.ingredients = ingredients
            existingRecipe.instructions = instructions
            existingRecipe.additionalNotes = additionalNotes
            existingRecipe.isFavorite = isFavorite
            
            do {
                try modelContext.save()
                print("Recipe successfully updated!")
            } catch {
                print("Failed to update recipe: \(error)")
            }
            
            updateCategoryAllRecipes()
            updateCategoryFavoriteRecipes()
            updateAllRecipes()
        }
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
    
    func fetchRecipe(by name: String) -> Recipe? {
        do {
            let descriptorRecipe = FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.title == name }
            )
            return try modelContext.fetch(descriptorRecipe).first
        } catch {
            print("Failed to fetch recipe: \(error)")
            return nil
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
        recipes = fetchAllRecipes()
    }
    
    func updateCategories() {
        categories = fetchRegularCategories()
    }
    
    func updateCategoryAllRecipes() {
        if let index = specialCategories.firstIndex(where: { $0.title == RecipeAppConstants.recipesKey }) {
            specialCategories[index].recipes = fetchAllRecipes()
        }
    }

    func updateCategoryFavoriteRecipes() {
        if let index = specialCategories.firstIndex(where: { $0.title == RecipeAppConstants.favoritesKey }) {
            specialCategories[index].recipes = fetchFavoriteRecipes()
        }
    }
}
