//
//  RecipeListView.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/12/24.
//

import SwiftUI

struct RecipeListView: View {
    let category: Category
    @State private var searchString: String = ""
    @Binding var selectedRecipe: Recipe?

    var recipes: [Recipe] {
        category.recipes
    }

    var body: some View {
        List(recipes.sorted(by: {$0.title < $1.title}), id: \.self, selection: $selectedRecipe) { recipe in
            Text(recipe.title)
        }
        .listStyle(.sidebar)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                EditButton()
//            }
//            ToolbarItem {
//                Button(action: addItem) {
//                    Label("Add Recipe", systemImage: "plus.app")
//                }
//            }
//        }
        .navigationTitle(category.title)
        .searchable(text: $searchString)

    }
    
    private func addItem() {
        withAnimation {
            //let newItem = Recipe(title: "\(Date())", ingredients: "Some ingredients", instructions: "Some instructions")
            //modelContext.insert(newItem)
            print("Insert Item")
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
