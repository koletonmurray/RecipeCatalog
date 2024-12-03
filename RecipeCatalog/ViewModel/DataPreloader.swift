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
            
            let shepherdsPie = Recipe(
                title: "Shepherds Pie",
                author: "Heidi W. Murray",
                dateAdded: Date(),
                minutesToCook: 60,
                servings: 6,
                difficulty: 3,
                caloriesPerServing: 350,
                ingredients: """
                - 1 pound ground beef
                - 1 finely chopped onion
                - Salt and pepper
                - Garlic powder and parsley
                - 1-2 cans green beans, drained
                - Two 8 oz cans tomato soup
                - Mashed potatoes (cooked)
                - Shredded cheese
                """,
                instructions: """
                - Boil and mash potatoes
                - Brown beef with onion, season, and spread in a 9x13 dish 
                - Add green beans and tomato soup to dish
                - Spread mashed potatoes on top and sprinkle with cheese
                - Bake at 350°F for 15-30 minutes until cheese is melted
                """,
                additionalNotes: "",
                isFavorite: true
            )
            let cajunChickenPasta = Recipe(
                title: "Cajun Chicken Pasta",
                author: "Heidi W Murray",
                dateAdded: Date(),
                minutesToCook: 40,
                servings: 4,
                difficulty: 2,
                caloriesPerServing: 400,
                ingredients: """
                - 2 boneless skinless chicken breasts
                - 4 teaspoons Cajun seasoning
                - 4 tablespoons butter or margarine
                - 3 cups heavy cream
                - 1 teaspoon salt
                - 1 teaspoon black pepper
                - 1/2 teaspoon garlic powder
                - 1/4 teaspoon lemon pepper seasoning
                - 8 ounces penne pasta, cooked and drained
                - 2 Roma tomatoes, diced
                - 1/4 cup Parmesan cheese, shredded
                """,
                instructions: """
                - In Ziploc bag, toss moist chicken in Cajun seasoning
                - Boil pasta until cooked
                - Sauté chicken in butter over medium heat until cooked through
                - In another skillet, combine heavy cream, butter, and seasonings; simmer until bubbling 
                - Add cooked pasta to the sauce and stir
                - Slice chicken into strips and serve over pasta
                - Top with diced tomatoes and Parmesan cheese
                """,
                additionalNotes: "Serve with garlic bread for a complete meal.",
                isFavorite: true
            )
            let meltInYourMouthChicken = Recipe(
                title: "Parmesan Melt-in-Your-Mouth Chicken",
                author: "Heidi W. Murray",
                dateAdded: Date(),
                minutesToCook: 60,
                servings: 4,
                difficulty: 2,
                caloriesPerServing: 350,
                ingredients: """
                - 4 boneless chicken breast halves
                - 1 cup mayonnaise
                - 1/2 cup freshly grated Parmesan cheese
                - 1 1/2 teaspoons seasoning salt
                - 1/2 teaspoon ground black pepper
                - 1 teaspoon garlic powder
                """,
                instructions: """
                - Mix mayonnaise, Parmesan cheese, and seasonings
                - Spread mixture over chicken breasts and place in a baking sheet
                - Bake at 375°F for 45 minutes until golden and cooked through
                """,
                additionalNotes: "Pairs well with roasted vegetables or a side salad."
            )
            let slowCookerCrackChicken = Recipe(
                title: "Slow Cooker Crack Chicken",
                author: "Cookies & Cups",
                dateAdded: Date(),
                minutesToCook: 480,
                servings: 6,
                difficulty: 1,
                caloriesPerServing: 500,
                ingredients: """
                - 2 lbs boneless chicken breasts
                - 2 (8 oz) blocks cream cheese
                - 2 (1 oz) packets dry Ranch seasoning
                - 8 oz bacon, cooked and crumbled
                """,
                instructions: """
                - Place chicken, cream cheese, and Ranch seasoning in a slow cooker. 
                - Cook on low for 6-8 hours or high for 4 hours. 
                - Shred chicken and mix with other ingredients. 
                - Stir in crumbled bacon and serve warm.
                """,
                additionalNotes: "Serve over rice, pasta, or with bread for a hearty meal."
            )
            let broccoliChickenCasserole = Recipe(
                title: "Broccoli Chicken Casserole",
                author: "Heidi W. Murray",
                dateAdded: Date(),
                minutesToCook: 75,
                servings: 8,
                difficulty: 2,
                caloriesPerServing: 400,
                ingredients: """
                - 1 1/2 cups sour cream
                - 2 cups cooked rice
                - 1/2 chopped onion
                - 1 can cream of chicken soup
                - 1 can cream of celery soup
                - 2 cups grated cheese
                - 1/4 cup cooked, chopped broccoli
                - 2 1/2 cups cooked, chunked chicken
                - Dash of garlic powder, seasoning salt, onion salt
                """,
                instructions: """
                - Cook rice
                - Cook chicken
                - Combine all ingredients, except 1/2 cup cheese 
                - Place in a 9x13 dish 
                - Sprinkle remaining cheese on top
                - Bake at 350°F for 45 minutes to 1 hour
                """,
                additionalNotes: ""
            )
            let porcupineMeatballs = Recipe(
                title: "Porcupine Meatballs",
                author: "Heidi W. Murray",
                dateAdded: Date(),
                minutesToCook: 60,
                servings: 6,
                difficulty: 2,
                caloriesPerServing: 300,
                ingredients: """
                - 1 1/2 lbs ground beef (thawed)
                - 1/2 cup uncooked rice
                - 1 teaspoon salt
                - 1/2 teaspoon pepper
                - 1 tablespoon dry minced onion
                - 1-2 cans tomato soup mixed with equal parts water
                """,
                instructions: """
                - Mix ground beef, rice, salt, pepper, and minced onion
                - Form into meatballs and place in a pot
                - Cover with tomato soup mixture
                - Simmer for 1 hour, or bake at 350°F for 1 hour
                """,
                additionalNotes: "Easy meal with baked potatoes",
                isFavorite: true
            )
            let taterTotCasserole = Recipe(
                title: "Tater Tot Casserole",
                author: "Heidi W. Murray",
                dateAdded: Date(),
                minutesToCook: 60,
                servings: 8,
                difficulty: 2,
                caloriesPerServing: 300,
                ingredients: """
                - 1 medium yellow onion, diced
                - 1 large green bell pepper, diced
                - 1 pound ground sausage
                - 1 teaspoon garlic powder
                - 1 teaspoon Italian seasoning
                - 6 slices cooked bacon, chopped
                - 2 cups shredded cheese
                - 6 eggs
                - 1.5 cups milk
                - Frozen tater tots
                """,
                instructions: """
                - Cook onion, pepper, and sausage with seasonings
                - Mix in 4 slices of chopped bacon
                - Transfer to a greased 9x13 pan, top with 1 cup of cheese and tater tots
                - Mix eggs and milk, pour over mixture, and top with more cheese and bacon 
                - Bake at 400°F for 35-50 minutes.
                """,
                additionalNotes: "",
                isFavorite: true
            )
            let germanPancakes = Recipe(
                title: "German Pancakes",
                author: "Heidi W. Murray",
                dateAdded: Date(),
                minutesToCook: 25,
                servings: 8,
                difficulty: 1,
                caloriesPerServing: 150,
                ingredients: """
                - 6 large eggs
                - 1 cup 2% milk
                - 1 cup all-purpose flour
                - 1/2 teaspoon salt
                - 2 tablespoons butter, melted
                - Powdered sugar
                - Fresh blueberries (optional)
                """,
                instructions: """
                - Blend eggs, milk, flour, and salt until smooth. 
                - Pour melted butter into a baking dish, add batter.
                - Bake at 400°F for 20 minutes. 
                - Dust with powdered sugar and optionally serve with blueberries.
                """,
                additionalNotes: "Delicious with homemade buttermilk syrup."
            )
            let buttermilkSyrup = Recipe(
                title: "Buttermilk Syrup",
                author: "Heidi W. Murray",
                dateAdded: Date(),
                minutesToCook: 10,
                servings: 8,
                difficulty: 1,
                caloriesPerServing: 100,
                ingredients: """
                - 3/4 cup buttermilk
                - 1 1/2 cups sugar
                - 1 stick real butter
                - 2 tablespoons corn syrup
                - 1 teaspoon baking soda
                - 1 teaspoon vanilla
                """,
                instructions: """
                - Combine buttermilk, sugar, butter, corn syrup, and baking soda in a large pot. 
                - Bring to a boil and reduce heat to low. 
                - Stir frequently for 8-9 minutes until golden brown. 
                - Remove from heat and add vanilla. 
                - Skim foam if desired.
                """,
                additionalNotes: "Great on pancakes or waffles."
            )
            let morningEggMuffins = Recipe(
                title: "Morning Egg Muffins",
                author: "Heidi W. Murray",
                dateAdded: Date(),
                minutesToCook: 35,
                servings: 6,
                difficulty: 2,
                caloriesPerServing: 120,
                ingredients: """
                - 6 large eggs
                - Pinch of salt and pepper
                - 1/2 teaspoon dried basil
                - 1/2 teaspoon dried oregano
                - 1 cup baby spinach, chopped
                - 1/2 cup finely diced red pepper
                - 1/2 cup finely diced green pepper
                - 8 cherry tomatoes, quartered
                - 70g feta cheese
                """,
                instructions: """
                - Mix eggs, salt, pepper, basil, and oregano. 
                - Add veggies and feta cheese. 
                - Divide evenly into greased muffin cups. 
                - Bake at 350°F for 20-25 minutes.
                """,
                additionalNotes: ""
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
                instructions: """
                - Grill chicken breast until cooked through.
                - Toss lettuce, tomatoes, and cucumbers in olive oil and lemon juice. 
                - Slice chicken and add to salad.
                """
            )
            let chocolateChipCookies = Recipe(
                title: "Chocolate Chip Cookies",
                author: "ChatGPT",
                dateAdded: Date(),
                minutesToCook: 20,
                servings: 24,
                difficulty: 1,
                caloriesPerServing: 200,
                ingredients: """
                - 2 1/4 cups all-purpose flour
                - 1 teaspoon baking soda
                - 1/2 teaspoon salt
                - 1 cup (2 sticks) unsalted butter, softened
                - 3/4 cup granulated sugar
                - 3/4 cup packed brown sugar
                - 1 teaspoon vanilla extract
                - 2 large eggs
                - 2 cups (12 oz) semi-sweet chocolate chips
                """,
                instructions: """
                1. Preheat oven to 375°F
                2. Combine flour, baking soda, and salt in a small bowl. Set aside
                3. Beat butter, granulated sugar, brown sugar, and vanilla extract in a large mixing bowl until creamy
                4. Add eggs one at a time, beating well after each addition
                5. Gradually beat in the flour mixture until fully incorporated
                6. Stir in chocolate chips
                7. Drop rounded tablespoons of dough onto ungreased baking sheets, spacing them about 2 inches apart
                8. Bake for 9-11 minutes, or until golden brown. Cool on baking sheets for 2 minutes, then transfer to wire racks to cool completely
                """,
                additionalNotes: "For softer cookies, bake slightly less; for crispier cookies, bake a bit longer."
            )
            
            modelContext.insert(shepherdsPie)
            modelContext.insert(cajunChickenPasta)
            modelContext.insert(meltInYourMouthChicken)
            modelContext.insert(slowCookerCrackChicken)
            modelContext.insert(broccoliChickenCasserole)
            modelContext.insert(porcupineMeatballs)
            modelContext.insert(taterTotCasserole)
            modelContext.insert(germanPancakes)
            modelContext.insert(buttermilkSyrup)
            modelContext.insert(morningEggMuffins)
            modelContext.insert(grilledChickenSalad)
            modelContext.insert(chocolateChipCookies)
    
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
            let managedShepherdsPie = try modelContext.fetch(FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.title == "Shepherds Pie" }
            )).first
            let managedCajunChickenPasta = try modelContext.fetch(FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.title == "Cajun Chicken Pasta" }
            )).first
            let managedMeltInYourMouthChicken = try modelContext.fetch(FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.title == "Parmesan Melt-in-Your-Mouth Chicken" }
            )).first
            let managedSlowCookerCrackChicken = try modelContext.fetch(FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.title == "Slow Cooker Crack Chicken" }
            )).first
            let managedBroccoliChickenCasserole = try modelContext.fetch(FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.title == "Broccoli Chicken Casserole" }
            )).first
            let managedPorcupineMeatballs = try modelContext.fetch(FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.title == "Porcupine Meatballs" }
            )).first
            let managedTaterTotCasserole = try modelContext.fetch(FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.title == "Tater Tot Casserole" }
            )).first
            let managedGermanPancakes = try modelContext.fetch(FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.title == "German Pancakes" }
            )).first
            let managedButtermilkSyrup = try modelContext.fetch(FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.title == "Buttermilk Syrup" }
            )).first
            let managedMorningEggMuffins = try modelContext.fetch(FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.title == "Morning Egg Muffins" }
            )).first
            let managedGrilledChickenSalad = try modelContext.fetch(FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.title == "Grilled Chicken Salad" }
            )).first
            let managedChocolateChipCookies = try modelContext.fetch(FetchDescriptor<Recipe>(
                predicate: #Predicate { $0.title == "Chocolate Chip Cookies" }
            )).first

            managedShepherdsPie?.categories.append(managedDinner!)
            managedCajunChickenPasta?.categories.append(managedDinner!)
            managedMeltInYourMouthChicken?.categories.append(managedDinner!)
            managedSlowCookerCrackChicken?.categories.append(managedDinner!)
            managedBroccoliChickenCasserole?.categories.append(managedDinner!)
            managedPorcupineMeatballs?.categories.append(managedDinner!)
            managedTaterTotCasserole?.categories.append(managedBreakfast!)
            managedGermanPancakes?.categories.append(managedBreakfast!)
            managedButtermilkSyrup?.categories.append(managedBreakfast!)
            managedMorningEggMuffins?.categories.append(managedBreakfast!)
            managedGrilledChickenSalad?.categories.append(managedLunch!)
            managedChocolateChipCookies?.categories.append(managedDessert!)

            try modelContext.save()
                        
            print("Preloaded data successfully")
        } catch {
            print("Failed to preload data: \(error)")
        }
    }
}
