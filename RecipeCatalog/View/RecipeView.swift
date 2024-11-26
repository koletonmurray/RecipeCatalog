//
//  RecipeView.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/12/24.
//

import SwiftUI

struct RecipeView: View {
    let recipe: Recipe
    @Binding var selectedCategory: Category?
    @Binding var selectedRecipe: Recipe?
    @Environment(RecipeViewModel.self) private var viewModel
    @State private var showEditRecipeForm = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(recipe.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.darkGreen)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 10)

                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Author: \(recipe.author)")
                            .font(.subheadline)
                            .foregroundStyle(.textSecondary)
                        
                        Text("Date Added: \(recipe.dateAdded, formatter: dateFormatter)")
                            .font(.subheadline)
                            .foregroundStyle(.textSecondary)
                    }
                    Spacer()
                }
                .padding(.bottom, 10)

                VStack {
                    Divider()
                    
                    HStack(spacing: 10) {
                        detailBox(title: "Minutes", value: "\(recipe.minutesToCook)")
                        detailBox(title: "Servings", value: "\(recipe.servings)")
                        difficultyBox(difficulty: recipe.difficulty)
                        detailBox(title: "Calories", subtitle: "Per Serving", value: "\(recipe.caloriesPerServing)")
                    }
                    .padding(10)
                    
                    Divider()
                }
                .background(Color.gray.opacity(0.05))

                VStack(alignment: .leading, spacing: 8) {
                    Text("Ingredients")
                        .title2Style()
                    Text(recipe.ingredients)
                        .font(.body)
                        .foregroundStyle(.textGray)
                }
                .padding(.horizontal, 10)

                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Instructions")
                        .title2Style()
                    Text(recipe.instructions)
                        .font(.body)
                        .foregroundStyle(.textGray)
                }
                .padding(.horizontal, 10)
                
                if recipe.additionalNotes.isEmpty == false {
                    VStack(alignment: .leading) {
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Additional Notes")
                                .title2Style()
                            Text(recipe.additionalNotes)
                                .font(.body)
                                .foregroundStyle(.textGray)
                        }
                        .padding(10)
                    }
                }
                                
                VStack(alignment: .leading, spacing: 8) {
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Categories")
                            .foregroundStyle(.darkGreen)
                            .fontWeight(.semibold)
                            .font(.title3)
                        HStack {
                            let categories = recipe.categories.sorted(by: { $0.title < $1.title })
                            ForEach(categories, id: \.self) { category in
                                Text("\(category.title)\(category != categories.last ? ", " : "")")
                                    .foregroundStyle(.textSecondary)
                                    .onTapGesture {
                                        selectedCategory = category
                                        selectedRecipe = nil
                                    }
                            }
                            .multilineTextAlignment(.leading)
                        }
                    }
                    .padding(10)
                    
                    Divider()
                }
                .background(Color.gray.opacity(0.05))
                

                Spacer(minLength: 20)
            }
            .frame(maxWidth: 500)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showEditRecipeForm = true
                    }) {
                        Image(systemName: "highlighter")
                            .foregroundStyle(.primary)
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        viewModel.toggleFavorite(for: recipe)
                    }) {
                        Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                            .foregroundStyle(.darkRed)
                    }
                }
            }
            .sheet(isPresented: $showEditRecipeForm) {
                RecipeForm(recipe: recipe, selectedRecipe: $selectedRecipe)
            }
        }
        .background(.backgroundGray)
        .navigationTitle(recipe.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    private func detailBox(title: String, subtitle: String? = nil, value: String) -> some View {
        VStack {
            Text(value)
                .font(.headline)
                .fontWeight(.semibold)
            VStack {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.textSecondary)
                if let subtitle {
                    Text(subtitle)
                        .font(.caption2)
                        .foregroundStyle(.textSecondary)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private func difficultyBox(difficulty: Int) -> some View {
        VStack {
            HStack(spacing: 4) {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= difficulty ? "frying.pan.fill" : "frying.pan")
                        .foregroundStyle(index <= difficulty ? .darkPurple : .gray)
                        .font(.caption2)
                }
            }
            Text("Difficulty")
                .font(.caption)
                .foregroundStyle(.textSecondary)
        }
        .frame(maxWidth: .infinity)
    }
}
