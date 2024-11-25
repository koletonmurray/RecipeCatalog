//
//  DataPreloader.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/19/24.
//

import Foundation
import SwiftData

class DataPreloader {
    static func preloadData(with modelContext: ModelContext) {
        do {
            let recipeCount = try modelContext.fetchCount(FetchDescriptor<Recipe>())
            let categoryCount = try modelContext.fetchCount(FetchDescriptor<Category>())
            
            guard recipeCount == 0 && categoryCount == 0 else {
                print("Data already exists. Skipping preload.")
                return
            }

            let existingSpecialCategories = try modelContext.fetch(FetchDescriptor<Category>(
                predicate: #Predicate { $0.specialCategory }
            ))
            
            if existingSpecialCategories.isEmpty {
                let allRecipes = Category(title: RecipeAppConstants.recipesKey, sfSymbol: "frying.pan", symbolColor: "", specialCategory: true)
                let favorites = Category(title: RecipeAppConstants.favoritesKey, sfSymbol: "heart.fill", symbolColor: "red", specialCategory: true)
                modelContext.insert(allRecipes)
                modelContext.insert(favorites)
                try modelContext.save()
            }
            
            let dessert = Category(title: "Dessert")
            let dinner = Category(title: "Dinner")
            let lunch = Category(title: "Lunch")
            let breakfast = Category(title: "Breakfast")
            
            modelContext.insert(dessert)
            modelContext.insert(dinner)
            modelContext.insert(lunch)
            modelContext.insert(breakfast)
            
            let chocolateChipCookies = Recipe(
                title: "Chocolate Chip Cookies",
                author: "ChatGPT",
                dateAdded: Date(),
                minutesToCook: 30,
                servings: 12,
                difficulty: 2,
                caloriesPerServing: 150,
                ingredients: """
                - 2 1/4 cups Flour
                - 1 cup Sugar
                - 1 cup Butter (softened)
                - 2 cups Chocolate Chips
                - 2 Eggs
                - 1 teaspoon Baking Soda
                """,
                instructions: "Mix ingredients, bake at 350°F for 10-12 minutes.",
                additionalNotes: "For gluten-free, use gluten-free flour.",
                isFavorite: true
            )
            
            let spaghetti = Recipe(
                title: "Spaghetti",
                author: "ChatGPT",
                dateAdded: Date(),
                minutesToCook: 25,
                servings: 4,
                difficulty: 1,
                caloriesPerServing: 400,
                ingredients: """
                - 12 oz Spaghetti
                - 2 cups Tomato Sauce
                - 1 lb Ground Beef
                - 1/4 cup Parmesan Cheese (grated)
                """,
                instructions: "Boil pasta, cook beef, mix with sauce, serve with cheese.",
                additionalNotes: "For gluten-free, substitute gluten-free pasta and likely cook for longer."
            )
            
            let pancakes = Recipe(
                title: "Pancakes",
                author: "ChatGPT",
                dateAdded: Date(),
                minutesToCook: 15,
                servings: 6,
                difficulty: 1,
                caloriesPerServing: 200,
                ingredients: """
                - 1 1/2 cups Flour
                - 3 1/2 teaspoons Baking Powder
                - 1 teaspoon Salt
                - 1 tablespoon Sugar
                - 1 1/4 cups Milk
                - 1 Egg
                - 3 tablespoons Butter (melted)
                """,
                instructions: "Mix ingredients, cook on a hot griddle, serve with syrup."
            )
            
            let blueberryMuffins = Recipe(
                title: "Blueberry Muffins",
                author: "ChatGPT",
                dateAdded: Date(),
                minutesToCook: 25,
                servings: 12,
                difficulty: 2,
                caloriesPerServing: 180,
                ingredients: """
                - 1 3/4 cups Flour
                - 1/2 cup Sugar
                - 2 teaspoons Baking Powder
                - 1/4 teaspoon Salt
                - 1/2 cup Milk
                - 1/4 cup Butter (melted)
                - 1 Egg
                - 1 cup Blueberries (fresh or frozen)
                """,
                instructions: "Mix flour, sugar, and baking powder. Add eggs, milk, and melted butter, then fold in blueberries. Bake at 375°F for 20-25 minutes."
            )
            
            let grilledChickenSalad = Recipe(
                title: "Grilled Chicken Salad",
                author: "ChatGPT",
                dateAdded: Date(),
                minutesToCook: 20,
                servings: 2,
                difficulty: 1,
                caloriesPerServing: 300,
                ingredients: """
                - 1 large head Romaine Lettuce (chopped)
                - 1/2 cup Caesar Dressing
                - 1/4 cup Parmesan Cheese (grated)
                - 1 cup Croutons
                - 1 grilled Chicken Breast (sliced)
                """,
                instructions: "Grill chicken breast until cooked through. Toss lettuce, tomatoes, and cucumbers in olive oil and lemon juice. Slice chicken and add to salad."
            )
            
            modelContext.insert(chocolateChipCookies)
            modelContext.insert(spaghetti)
            modelContext.insert(pancakes)
            modelContext.insert(blueberryMuffins)
            modelContext.insert(grilledChickenSalad)
    
            try modelContext.save()
            
            let managedDessert = try modelContext.fetch(FetchDescriptor<Category>(
                predicate: #Predicate { $0.title == "Dessert" }
            )).first
            let managedDinner = try modelContext.fetch(FetchDescriptor<Category>(
                predicate: #Predicate { $0.title == "Dinner" }
            )).first
            let managedLunch = try modelContext.fetch(FetchDescriptor<Category>(
                predicate: #Predicate { $0.title == "Lunch" }
            )).first
            let managedBreakfast = try modelContext.fetch(FetchDescriptor<Category>(
                predicate: #Predicate { $0.title == "Breakfast" }
            )).first


            let managedCookies = try modelContext.fetch(FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.title == "Chocolate Chip Cookies" }
            )).first
            let managedSpaghetti = try modelContext.fetch(FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.title == "Spaghetti" }
            )).first
            let managedPancakes = try modelContext.fetch(FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.title == "Pancakes" }
            )).first
            let managedBlueberryMuffins = try modelContext.fetch(FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.title == "Blueberry Muffins" }
            )).first
            let managedGrilledChickenSalad = try modelContext.fetch(FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.title == "Grilled Chicken Salad" }
            )).first

            managedCookies?.categories.append(managedDessert!)
            managedSpaghetti?.categories.append(managedDinner!)
            managedPancakes?.categories.append(managedBreakfast!)
            managedBlueberryMuffins?.categories.append(managedBreakfast!)
            managedGrilledChickenSalad?.categories.append(managedLunch!)

            try modelContext.save()
                        
            print("Preloaded data successfully")
        } catch {
            print("Failed to preload data: \(error)")
        }
    }
}
