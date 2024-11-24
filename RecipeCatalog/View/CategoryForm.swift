//
//  CategoryForm.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/23/24.
//

import SwiftUI

struct CategoryForm: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(RecipeViewModel.self) private var viewModel
    @State private var categoryTitle = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Category Details")) {
                    TextField("Category Name", text: $categoryTitle)
                }
            }
            .navigationTitle("New Cateogry")
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
                        viewModel.createCategory(
                            categoryTitle: categoryTitle
                        )
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

#Preview {
    CategoryForm()
}
