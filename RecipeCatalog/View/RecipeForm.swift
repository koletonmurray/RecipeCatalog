//
//  RecipeForm.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/23/24.
//

import SwiftUI

struct RecipeForm: View {
    @State var recipe: Recipe?
    @Environment(\.dismiss) private var dismiss
    @Environment(RecipeViewModel.self) private var viewModel
    @Binding var selectedRecipe: Recipe?
    @State private var recipeName: String
    @State private var author: String
    @State private var cookTime: Int
    @State private var servings: Int
    @State private var calories: Int
    @State private var difficulty: Int
    @State private var isFavorite: Bool
    @State private var ingredients: String
    @State private var instructions: String
    @State private var additionalNotes: String
    @State private var categories: [Category]
    @State private var showAddCategoryForm = false
    @State private var showDeleteAlert = false
    
    init(recipe: Recipe?, selectedRecipe: Binding<Recipe?>) {
        self.recipe = recipe
        self._selectedRecipe = selectedRecipe
        _recipeName = State(initialValue: recipe?.title ?? "")
        _author = State(initialValue: recipe?.author ?? "")
        _cookTime = State(initialValue: recipe?.minutesToCook ?? 5)
        _servings = State(initialValue: recipe?.servings ?? 1)
        _calories = State(initialValue: recipe?.caloriesPerServing ?? 0)
        _difficulty = State(initialValue: recipe?.difficulty ?? 1)
        _isFavorite = State(initialValue: recipe?.isFavorite ?? false)
        _ingredients = State(initialValue: recipe?.ingredients ?? "")
        _instructions = State(initialValue: recipe?.instructions ?? "")
        _additionalNotes = State(initialValue: recipe?.additionalNotes ?? "")
        _categories = State(initialValue: recipe?.categories ?? [])
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Recipe Details")) {
                    HStack {
                        Text("Recipe Name:")
                            .foregroundStyle(.gray)
                        Spacer()
                        TextField("Recipe Name", text: $recipeName)
                            .frame(maxWidth: 300)
                    }
                    HStack {
                        Text("Author:")
                            .foregroundStyle(.gray)
                        Spacer()
                        TextField("Author", text: $author)
                            .frame(maxWidth: 300)
                    }
                    
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
                    
                    HStack {
                        Text("Favorite:")
                            .foregroundStyle(.gray)
                        Spacer()
                        Button(action: {
                            isFavorite.toggle()
                        }) {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .foregroundStyle(.darkRed)
                                .font(.title3)
                        }
                    }
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
                

                Section(header: Text("Categories")) {
                    if !categories.filter({ !$0.specialCategory }).isEmpty {
                        ForEach(categories
                            .filter{ !$0.specialCategory }
                            .sorted(by: { $0.title < $1.title }), id: \.self) { category in
                                HStack {
                                    Text(category.title)
                                    Spacer()
                                    Button {
                                        removeCategory(category)
                                    } label: {
                                        Image(systemName: "trash")
                                            .foregroundStyle(.red)
                                    }
                                }
                            }
                    } else {
                        Text("No Categories")
                            .font(.title3)
                            .foregroundStyle(.gray)
                    }
                    Button {
                        showAddCategoryForm = true
                    } label: {
                        HStack {
                            Spacer()
                            Label("Add Category", systemImage: "plus")
                                .font(.title3)
                            Spacer()
                        }
                        .foregroundStyle(.darkGreen)
                    }
                }
                
                if (recipe != nil) {
                    Section {
                        HStack {
                            Spacer()
                            Button(action: {
                                showDeleteAlert = true
                            }) {
                                Text("Delete Recipe")
                                    .foregroundStyle(.red)
                                    .font(.title3)
                            }
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle(recipe == nil ? "New Recipe" : "Edit Recipe")
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
                        if recipe != nil {
                            viewModel.updateRecipe(
                                existingRecipe: recipe,
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
                        } else {
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
                                isFavorite: isFavorite,
                                categories: categories
                            )
                        }
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark.rectangle.fill")
                    }
                    .foregroundStyle(.darkGreen)
                }
            }
            .sheet(isPresented: $showAddCategoryForm) {
                AddCategoryToRecipeForm(recipe: recipe, categories: $categories)
            }
            .alert("Would you like to permanently delete this recipe \"\(recipeName)\"?", isPresented: $showDeleteAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {
                    viewModel.deleteRecipe(recipe: recipe!)
                    selectedRecipe = nil
                    showDeleteAlert = false
                    dismiss()
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
    
    private func removeCategory(_ category: Category) {
        categories.removeAll(where: { $0.title == category.title })
        
        if let recipe = recipe {
            viewModel.removeRecipeFromCategory(recipe: recipe, category: category)
            viewModel.updateRecipe(
                existingRecipe: recipe,
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
        }
    }
}
