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
    @State private var showAddRecipeForm = false
    @State private var showDeleteAlert = false
    
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
                
                Section(header: Text("Recipes in Category")) {
                    if !recipes.isEmpty {
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
                    } else {
                        Text("No Recipes")
                            .font(.title3)
                            .foregroundStyle(.gray)
                    }
                    Button {
                        showAddRecipeForm = true
                    } label: {
                        HStack {
                            Spacer()
                            Label("Add Recipe", systemImage: "plus")
                                .foregroundStyle(.darkGreen)
                                .font(.title3)
                            Spacer()
                        }
                        .foregroundStyle(.darkGreen)
                    }
                }
                    
                if (category != nil && category?.specialCategory == false) {
                    Section {
                        HStack {
                            Spacer()
                            Button(action: {
                                showDeleteAlert = true
                            }) {
                                Text("Delete Category")
                                    .foregroundStyle(.red)
                                    .font(.title3)
                            }
                            Spacer()
                        }
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
                                categoryTitle: categoryTitle,
                                recipes: recipes
                            )
                        }
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark.rectangle.fill")
                    }
                    .foregroundStyle(.darkGreen)
                }
            }
            .sheet(isPresented: $showAddRecipeForm) {
                AddRecipeToCategoryForm(category: category, recipes: $recipes)
            }
            .alert("Would you like to permanently delete this category \"\(categoryTitle)\"?", isPresented: $showDeleteAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {
                    viewModel.deleteCategory(category: category!)
                    selectedCategory = nil
                    showDeleteAlert = false
                    dismiss()
                }
            }
                
        }
    }
    
    private func removeRecipe(_ recipe: Recipe) {
        recipes.removeAll(where: { $0.title == recipe.title })
        
        if let category = category {
            viewModel.removeRecipeFromCategory(
                recipe: recipe,
                category: category
            )
        }
    }
}
