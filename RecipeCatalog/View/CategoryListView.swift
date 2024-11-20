//
//  CategoryListView.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/12/24.
//

import SwiftUI

struct CategoryListView: View {
    @Binding var selectedCategory: String?
    @State private var searchString: String = ""

    let categories = ["Appetizers", "Main Dishes", "Desserts", "Drinks"]

    var body: some View {
        List(selection: $selectedCategory) {
                // Section for predefined items
                Section {
                    Text("All Recipes")
                    Text("Favorites")
                }
                
                // Header for categories
                Section(header: Text("Categories")) {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                    }
                }
            }
        .listStyle(.sidebar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addItem) {
                    Label("Add Recipe", systemImage: "plus")
                }
            }
        }
        .searchable(text: $searchString)
    }

    private func addItem() {
        withAnimation {
            let newItem = Recipe(title: "\(Date())", ingredients: "Some ingredients", instructions: "Some instructions")
            //modelContext.insert(newItem)
            print("Insert \(newItem)")
        }
    }
}

#Preview {
    CategoryListView(selectedCategory: .constant(""))
}
