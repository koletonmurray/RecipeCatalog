//
//  RecipeListView.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/12/24.
//

import SwiftUI

struct RecipeListView: View {
    let category: Category
    @Binding var selectedCategory: Category?
    @Binding var selectedRecipe: Recipe?
    @State private var showAddRecipeForm = false
    @State private var showEditCategoryForm = false
    @State private var typedSearchString: String = ""

    var recipes: [Recipe] {
        category.recipes
    }

    var body: some View {
        Group {
            if (recipes.isEmpty) {
                VStack {
                    if (category.title == RecipeAppConstants.favoritesKey) {
                        Text("No Favorite Recipes")
                            .font(.largeTitle)
                            .foregroundStyle(.gray)
                            .padding(.bottom, 10)
                        Text("Click the heart icon above a recipe to add it to your favorites.")
                            .font(.title3)
                            .foregroundStyle(.gray)
                    } else if (category.title == RecipeAppConstants.recipesKey) {
                        Text("No Recipes")
                            .font(.largeTitle)
                            .foregroundStyle(.gray)
                            .padding(.bottom, 10)
                        Text("Click the file with the plus icon above to add new recipes to your digital recipe book.")
                            .font(.title3)
                            .foregroundStyle(.gray)
                    } else {
                        Text("No Recipes Tagged")
                            .font(.largeTitle)
                            .foregroundStyle(.gray)
                            .padding(.bottom, 10)
                        Text("Click the pencil icon above to add recipes to this category.")
                            .font(.title3)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                }
                .padding(30)
            } else {
                List(selection: $selectedRecipe) {
                    Section(header: Text("Recipes")) {
                        ForEach(recipes
                            .filter {
                                typedSearchString.isEmpty || $0.searchString.localizedCaseInsensitiveContains(typedSearchString)
                            }
                            .sorted(by: { $0.title < $1.title }), id: \.self) { recipe in
                                Text(recipe.title)
                            }
                    }
                }
                .listStyle(.sidebar)
                .searchable(text: $typedSearchString, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search (recipes, ingredients, etc.)")

            }
        }
        .toolbar {
            if (!category.specialCategory) {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showEditCategoryForm = true
                    }) {
                        Image(systemName: "highlighter")
                            .foregroundStyle(.primary)
                    }
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    showAddRecipeForm = true
                }) {
                    Image(systemName: "document.badge.plus")
                        .foregroundStyle(.primary)
                }
            }
        }
        .sheet(isPresented: $showAddRecipeForm) {
            RecipeForm(recipe: nil, selectedRecipe: .constant(nil))
        }
        .sheet(isPresented: $showEditCategoryForm) {
            CategoryForm(category: category, selectedCategory: $selectedCategory)
        }
        .navigationTitle(category.title)
    }
}
