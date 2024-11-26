//
//  CategoryForm.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/23/24.
//

import SwiftUI

struct CategoryForm: View {
    let category: Category?
    @Binding var selectedCategory: Category?
    @Environment(\.dismiss) private var dismiss
    @Environment(RecipeViewModel.self) private var viewModel
    @State private var categoryTitle: String
    @State private var recipes: [Recipe]
    
    init(category: Category?, selectedCategory: Binding<Category?>) {
        self.category = category
        self._selectedCategory = selectedCategory
        _categoryTitle = State(initialValue: category?.title ?? "")
        _recipes = State(initialValue: category?.recipes ?? [])
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Category Name")) {
                    TextField("Category Name", text: $categoryTitle)
                }
                
                if !recipes.isEmpty {
                    Section(header: Text("Recipes in Category")) {
                        ForEach(recipes.sorted(by: { $0.title < $1.title }), id: \.self) { recipe in
                            HStack {
                                Text(recipe.title)
                                Spacer()
                                Button {
                                    removeRecipe(recipe)
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundStyle(.red)
                                }
                            }
                        }
                    }
                }
                
                if (category != nil && category?.specialCategory == false) {
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.deleteCategory(category: category!)
                            selectedCategory = nil
                            dismiss()
                        }) {
                            Text("Delete Category")
                                .foregroundStyle(.red)
                                .font(.title3)
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle(category == nil ? "New Category" : "Edit Category")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.rectangle")
                    }
                    .foregroundStyle(.darkRed)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        if category != nil {
                            viewModel.updateCategory(
                                existingCategory: selectedCategory,
                                categoryTitle: categoryTitle
                            )
                        } else {
                            viewModel.createCategory(
                                categoryTitle: categoryTitle
                            )
                        }
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark.rectangle.fill")
                    }
                    .foregroundStyle(.darkGreen)
                }
            }
        }
    }
    
    private func removeRecipe(_ recipe: Recipe) {
        if let category = category {
            recipes.removeAll(where: { $0.title == recipe.title })
            viewModel.removeRecipeFromCategory(recipe: recipe, category: category)
        }
    }
}
