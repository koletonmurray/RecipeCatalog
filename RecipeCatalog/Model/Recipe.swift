//
//  Recipe.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/12/24.
//

import Foundation
import SwiftData

@Model
final class Recipe {
    @Attribute(.unique) var title: String
    var author: String
    var dateAdded: Date
    var minutesToCook: Int
    var servings: Int
    var difficulty: Int
    var caloriesPerServing: Int
    var additionalNotes: String
    var ingredients: String
    var instructions: String
    var isFavorite: Bool
    var searchString: String
    
    @Relationship(deleteRule: .nullify) var categories: [Category] = []

//    var description: String {
//        """
//        Recipe:
//        - Title: \(title)
//        - Author: \(author)
//        - Date Added: \(dateAdded)
//        - Minutes to Cook: \(minutesToCook)
//        - Servings: \(servings)
//        - Difficulty: \(difficulty)
//        - Calories per Serving: \(caloriesPerServing)
//        - Ingredients: \(ingredients)
//        - Instructions: \(instructions)
//        - Favorited: \(isFavorite)
//        - Categories: \(categories.map { $0.title }.joined(separator: ", "))
//        """
//    }
    
    init(title: String, author: String, dateAdded: Date, minutesToCook: Int, servings: Int, difficulty: Int, caloriesPerServing: Int, additionalNotes: String = "", ingredients: String, instructions: String, isFavorite: Bool = false) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.minutesToCook = minutesToCook
        self.servings = servings
        self.difficulty = difficulty
        self.caloriesPerServing = caloriesPerServing
        self.additionalNotes = additionalNotes
        self.ingredients = ingredients
        self.instructions = instructions
        self.isFavorite = isFavorite
        self.searchString = title.lowercased() + " " + ingredients.lowercased() + " " + instructions.lowercased()
    }
}
