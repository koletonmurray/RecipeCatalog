//
//  MainView.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/12/24.
//

import SwiftUI

struct MainView: View {
    
    // ChatGPT helped me come up with a state var to help me
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var selectedCategory: String?
    @State private var selectedRecipe: String?
    
    var body: some View {
        NavigationSplitView (columnVisibility: $columnVisibility) {
            CategoryListView(selectedCategory: $selectedCategory)
                .navigationTitle("Categories")
        } content: {
            if let category = selectedCategory {
                RecipeListView(category: category, selectedRecipe: $selectedRecipe)
            } else {
                Text("Select a Category")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }
                
        } detail: {
            if let recipe = selectedRecipe {
                RecipeView(recipe: recipe)
            } else {
                Text("Select a Recipe")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }
        }
        .onChange(of: selectedRecipe) {
            // ChatGPT helped me with this to collapse sidebar when a recipe is selected
            if UIDevice.current.userInterfaceIdiom == .pad && (columnVisibility == .all || columnVisibility == .doubleColumn) {
                columnVisibility = .detailOnly
            }
        }
    }
}

#Preview {
    MainView()
}
