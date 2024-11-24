//
//  MainView.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/12/24.
//

import SwiftUI

struct MainView: View {
    
    // ChatGPT helped me come up with a state var to help me contol column visibility (see onchange below)
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var hasInitializedCategory = false
    @State private var selectedCategory: Category?
    @State private var selectedRecipe: Recipe?
    @Environment(RecipeViewModel.self) private var viewModel
    
    // ChatGPT did the following init to help me set the color of my navigationTitles to follow my color scheme
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.darkGreen
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.darkGreen
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        NavigationSplitView (columnVisibility: $columnVisibility) {
            CategoryListView(selectedCategory: $selectedCategory)
                .navigationTitle("Categories")
                .onAppear {
                    if !hasInitializedCategory {
                        selectedCategory = viewModel.specialCategories.first(where: { $0.title == RecipeAppConstants.recipesKey })
                        hasInitializedCategory = true
                    }
                }
        } content: {
            if let category = selectedCategory {
                RecipeListView(category: category, selectedRecipe: $selectedRecipe)
            } else {
                Text("Select a Category")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
            }
                
        } detail: {
            if let recipe = selectedRecipe {
                RecipeView(recipe: recipe)
            } else {
                Text("Select a Recipe")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
            }
        }
        .onChange(of: selectedRecipe) {
            // ChatGPT helped me collapse sidebar when a recipe is selected
            if UIDevice.current.userInterfaceIdiom == .pad && (columnVisibility == .all || columnVisibility == .doubleColumn) {
                columnVisibility = .detailOnly
            }
        }
    }
}

#Preview {
    MainView()
}
