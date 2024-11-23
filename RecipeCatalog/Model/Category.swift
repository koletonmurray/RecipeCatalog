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
    var specialCategory: Bool
    
    @Relationship(deleteRule: .nullify, inverse: \Recipe.categories) var recipes: [Recipe] = []

    init(title: String, specialCategory: Bool = false) {
        self.title = title
        self.specialCategory = specialCategory
    }
    
//    var description: String {
//        """
//        Category:
//        - Title: \(title)
//        - Recipes: \(recipes.isEmpty ? "No recipes available" : recipes.map { $0.title }.joined(separator: ", "))
//        """
//    }
}
