//
//  RecipeListView.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/12/24.
//

import SwiftUI

struct RecipeListView: View {
    let category: Category
    @State private var typedSearchString: String = ""
    @Binding var selectedRecipe: Recipe?
    @State private var showRecipeForm = false

    var recipes: [Recipe] {
        category.recipes
    }

    var body: some View {
        List(selection: $selectedRecipe) {
            Section(header: Text("Recipes")) {
                ForEach(recipes.filter {
                    typedSearchString.isEmpty || $0.searchString.localizedCaseInsensitiveContains(typedSearchString)
                }
                .sorted(by: { $0.title < $1.title }), id: \.self) { recipe in
                    Text(recipe.title)
                }
            }
        }
        .listStyle(.sidebar)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    showRecipeForm = true
                }) {
                    Label("New Recipe", systemImage: "document.badge.plus")
                }
            }
        }
        .sheet(isPresented: $showRecipeForm) {
            RecipeForm()
        }
        .navigationTitle(category.title)
        .searchable(text: $typedSearchString, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search (recipes, ingredients, etc.)")
    }
}
