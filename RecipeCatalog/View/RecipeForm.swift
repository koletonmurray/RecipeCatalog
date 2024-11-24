//
//  RecipeForm.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/23/24.
//

import SwiftUI

struct RecipeForm: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(RecipeViewModel.self) private var viewModel
    @State private var recipeName = ""
    @State private var author = ""
    @State private var cookTime: Int = 5
    @State private var servings: Int = 1
    @State private var calories: Int = 0
    @State private var difficulty: Int = 1
    @State private var isFavorite = false
    @State private var ingredients = ""
    @State private var instructions = ""
    @State private var additionalNotes = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Recipe Details")) {
                    TextField("Recipe Name", text: $recipeName)
                    
                    TextField("Author", text: $author)
                    
                    HStack {
                        Text("Total Time:")
                            .foregroundStyle(.gray)
                        Spacer()

                        Text("\(cookTime) minutes")

                        Stepper("", value: $cookTime, in: 0...480, step: 5)
                            .labelsHidden()
                    }
                    
                    HStack {
                        Text("Servings:")
                            .foregroundStyle(.gray)

                        Spacer()

                        Text("\(servings)")
                            .padding(.horizontal)

                        Stepper("", value: $servings, in: 1...100, step: 1)
                            .labelsHidden()
                    }
                    
                    HStack {
                        Text("Calories:")
                            .foregroundStyle(.gray)
                        Spacer()

                        Text("\(calories) per serving")

                        Stepper("", value: $calories, in: 0...1000, step: 10)
                            .labelsHidden()
                    }
                    DifficultyRating(difficulty: $difficulty)
                    Toggle("Favorite: ", isOn: $isFavorite)
                        .foregroundStyle(.gray)
                }
                
                Section(header: Text("Ingredients:")) {
                    TextEditor(text: $ingredients)
                        .frame(minHeight: 100)
                }
                
                Section(header: Text("Instructions:")) {
                    TextEditor(text: $instructions)
                        .frame(minHeight: 100)
                }
                
                Section(header: Text("Additional Notes: (optional)")) {
                    TextEditor(text: $additionalNotes)
                        .frame(minHeight: 100)
                }
            }
            .navigationTitle("New Recipe")
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
                        viewModel.createRecipe(
                            recipeName: recipeName,
                            author: author,
                            cookTime: cookTime,
                            servings: servings,
                            difficulty: difficulty,
                            calories: calories,
                            ingredients: ingredients,
                            instructions: instructions,
                            additionalNotes: additionalNotes,
                            isFavorite: isFavorite
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
    
    struct DifficultyRating: View {
        @Binding var difficulty: Int

        var body: some View {
            HStack {
                Text("Difficulty:")
                    .foregroundStyle(.gray)

                Spacer()

                HStack(spacing: 5) {
                    ForEach(1...5, id: \.self) { star in
                        Image(systemName: star <= difficulty ? "frying.pan.fill" : "frying.pan")
                            .foregroundStyle(star <= difficulty ? .darkPurple: .gray)
                            .onTapGesture {
                                difficulty = star
                            }
                            .font(.title3)
                    }
                }
            }
            .padding(.vertical, 5)
        }
    }
}

#Preview {
    RecipeForm()
}
