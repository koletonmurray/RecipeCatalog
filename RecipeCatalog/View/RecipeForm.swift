//
//  RecipeForm.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/23/24.
//

import SwiftUI

struct RecipeForm: View {
    @Environment(\.dismiss) private var dismiss // For dismissing the sheet
    @State private var recipeName: String = ""
    @State private var cookingTime: Int = 0
    @State private var servings: Int = 1
    @State private var isFavorite: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Recipe Details")) {
                    TextField("Recipe Name", text: $recipeName)
                    Stepper("Cooking Time: \(cookingTime) minutes", value: $cookingTime, in: 0...240)
                    Stepper("Servings: \(servings)", value: $servings, in: 1...20)
                    Toggle("Favorite", isOn: $isFavorite)
                }
            }
            .navigationTitle("New Recipe")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss() // Dismiss the sheet
                    }
                    .foregroundStyle(.red)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // Handle save logic here
                        dismiss() // Dismiss the sheet
                    }
                    .foregroundStyle(.green)
                }
            }
        }
    }
}

#Preview {
    RecipeForm()
}
