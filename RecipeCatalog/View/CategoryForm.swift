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
    
    init(category: Category?, selectedCategory: Binding<Category?>) {
        self.category = category
        self._selectedCategory = selectedCategory
        _categoryTitle = State(initialValue: category?.title ?? "")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Category Details")) {
                    TextField("Category Name", text: $categoryTitle)
                }
                
                if (category != nil) {
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
}
