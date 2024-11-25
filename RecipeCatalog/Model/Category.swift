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
    var sfSymbol: String
    var symbolColor: String
    var specialCategory: Bool
    
    @Relationship(deleteRule: .nullify, inverse: \Recipe.categories) var recipes: [Recipe] = []

    init(title: String, sfSymbol: String = "", symbolColor: String = "", specialCategory: Bool = false) {
        self.title = title
        self.sfSymbol = sfSymbol
        self.symbolColor = symbolColor
        self.specialCategory = specialCategory
    }
}
