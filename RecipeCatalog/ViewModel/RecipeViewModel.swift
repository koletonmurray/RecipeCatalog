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
        fetchData()
    }
    
    // MARK: - Model Access
    
    private(set) var categories: [Category] = []
    private(set) var favorites: [Recipe] = []
    private(set) var recipes: [Recipe] = []
    // Array of categories
    
    // Search by keyword
    
    
    
    // MARK: - Functions
    
    func fetchData() {
        try? modelContext.save()
        
        do {
            let descriptor = FetchDescriptor<Recipe>(sortBy: [SortDescriptor(\.title)])
            //let gatheredFavorites = See slides to get favorites
            
            recipes = try modelContext.fetch(descriptor)
            // favorites = try modelContext.fetch(gatheredFavorites)
        } catch {
            print("Failed to load recipes")
        }
    }
}
