//
//  RecipeView.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/12/24.
//

import SwiftUI

struct RecipeView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(recipe.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 10)

                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Author: \(recipe.author)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text("Date Added: \(recipe.dateAdded, formatter: dateFormatter)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
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
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(recipe.ingredients)
                        .font(.body)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 10)

                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Instructions")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(recipe.instructions)
                        .font(.body)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 10)

                Spacer(minLength: 20)
            }
            .frame(maxWidth: 500)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
        }
        .navigationTitle(recipe.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func detailBox(title: String, subtitle: String? = nil, value: String) -> some View {
            VStack {
                Text(value)
                    .font(.headline)
                    .fontWeight(.semibold)
                VStack {
                    Text(title)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    if let subtitle {
                        Text(subtitle)
                            .font(.caption2)
                            .foregroundColor(.secondary)
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
                            .foregroundColor(index <= difficulty ? .blue : .gray)
                            .font(.caption2)
                    }
                }
                Text("Difficulty")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
        }

        // Date Formatter
        private var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter
        }
}
