//
//  RecipeListView.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/12/24.
//

import SwiftUI

struct RecipeListView: View {
    let category: String
    @Binding var selectedRecipe: String?

    var recipes: [String] {
        switch category {
        case "Appetizers":
            return ["Bruschetta", "Stuffed Mushrooms", "Spring Rolls"]
        case "Main Dishes":
            return ["Spaghetti Carbonara", "Grilled Chicken", "Beef Tacos"]
        case "Desserts":
            return ["Chocolate Cake", "Apple Pie", "Cheesecake"]
        case "Drinks":
            return ["Margarita", "Mojito", "Iced Tea"]
        default:
            return []
        }
    }

    var body: some View {
        List(recipes, id: \.self, selection: $selectedRecipe) { recipe in
            Text(recipe)
        }
        .listStyle(.sidebar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addItem) {
                    Label("Add Recipe", systemImage: "plus.app")
                }
            }
        }
        .navigationTitle(category)

    }
    
    private func addItem() {
        withAnimation {
            let newItem = Recipe(title: "\(Date())", ingredients: "Some ingredients", instructions: "Some instructions")
            //modelContext.insert(newItem)
            print("Insert \(newItem)")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                //modelContext.delete(recipes[index])
                print("Delete \(index)" )
            }
        }
    }
}

#Preview {
    RecipeListView(category: "Appetizers", selectedRecipe: .constant(""))
}
