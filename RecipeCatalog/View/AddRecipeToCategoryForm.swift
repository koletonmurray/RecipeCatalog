//
//  AddRecipeToCategoryForm.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/25/24.
//

import SwiftUI

struct AddRecipeToCategoryForm: View {
    let category: Category
    @Binding var recipes: [Recipe]
    @Environment(\.dismiss) private var dismiss
    @Environment(RecipeViewModel.self) private var viewModel
    @State private var typedSearchString: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Form {
                    Section(header: Text("Available recipes")) {
                        ForEach(viewModel.recipes
                            .filter { !category.recipes.contains($0) }
                            .filter { typedSearchString.isEmpty || $0.searchString.localizedCaseInsensitiveContains(typedSearchString) }
                        ) { recipe in
                            Button {
                                viewModel.addRecipeToCategory(recipe: recipe, category: category)
                                recipes.append(recipe)
                            } label: {
                                HStack {
                                    Text(recipe.title)
                                        .foregroundStyle(.textGray)
                                        .fontWeight(.medium)
                                    Spacer()
                                    Image(systemName: "plus")
                                        .foregroundStyle(.darkGreen)
                                        .fontWeight(.bold)
                                }
                            }
                        }
                    }
                }
            }
            //.padding(.top, 15)
            .navigationTitle("Add Recipes to \(category.title)")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.rectangle")
                            .foregroundStyle(.darkRed)
                    }
                }
            }
            .searchable(text: $typedSearchString, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search (recipes, ingredients, etc.)")
        }
    }
}
