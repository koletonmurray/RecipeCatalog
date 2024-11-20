//
//  Category.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/19/24.
//

import Foundation
import SwiftData

@Model
final class Category {
    @Attribute(.unique) var title: String
    var ingredients: String
    var instructions: String
    var searchString: String
    
    init(title: String, ingredients: String, instructions: String) {
        self.title = title
        self.ingredients = ingredients
        self.instructions = instructions
        self.searchString = title.lowercased() + " " + ingredients.lowercased() + " " + instructions.lowercased()
    }
}
