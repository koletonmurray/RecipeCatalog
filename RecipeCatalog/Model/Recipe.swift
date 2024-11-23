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
    var ingredients: String
    var instructions: String
    var additionalNotes: String
    var isFavorite: Bool
    var searchString: String
    
    @Relationship(deleteRule: .nullify) var categories: [Category] = []
    
    init(title: String, author: String, dateAdded: Date, minutesToCook: Int, servings: Int, difficulty: Int, caloriesPerServing: Int, ingredients: String, instructions: String, additionalNotes: String = "", isFavorite: Bool = false) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.minutesToCook = minutesToCook
        self.servings = servings
        self.difficulty = difficulty
        self.caloriesPerServing = caloriesPerServing
        self.ingredients = ingredients
        self.instructions = instructions
        self.additionalNotes = additionalNotes
        self.isFavorite = isFavorite
        self.searchString = title.lowercased() + " " + ingredients.lowercased() + " " + instructions.lowercased()
    }
}
