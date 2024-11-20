//
//  MainView.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/12/24.
//

import SwiftUI
import SwiftData

struct DefaultMainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var recipes: [Recipe]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(recipes) { recipe in
                    NavigationLink {
                        Text(recipe.title)
                        Text(recipe.ingredients)
                        Text(recipe.instructions)
                    } label: {
                        Text(recipe.title)
                    }
                }
                .onDelete(perform: deleteItems)
            }
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
        } detail: {
            Text("Select a Recipe")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Recipe(title: "\(Date())", ingredients: "Some ingredients", instructions: "Some instructions")
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(recipes[index])
            }
        }
    }
}

#Preview {
    DefaultMainView()
        .modelContainer(for: Recipe.self, inMemory: true)
}
