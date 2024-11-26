//
//  AddCategoryToRecipeForm.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/25/24.
//

import SwiftUI

struct AddCategoryToRecipeForm: View {
    let recipe: Recipe
    @Binding var categories: [Category]
    @Environment(\.dismiss) private var dismiss
    @Environment(RecipeViewModel.self) private var viewModel
    @State private var typedSearchString: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Form {
                    ForEach(viewModel.categories
                        .filter { !recipe.categories.contains($0) }
                        .filter { typedSearchString.isEmpty || $0.title.localizedCaseInsensitiveContains(typedSearchString) }
                    ) { category in
                        Button {
                            viewModel.addRecipeToCategory(recipe: recipe, category: category)
                            categories.append(category)
                        } label: {
                            HStack {
                                Text(category.title)
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
            .padding(.top, 15)
            .navigationTitle("Add Categories to \(recipe.title)")
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
