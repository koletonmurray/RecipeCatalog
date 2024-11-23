//
//  CategoryListView.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/12/24.
//

import SwiftUI

struct CategoryListView: View {
    @Binding var selectedCategory: Category?
    @State private var searchString: String = ""
    @Environment(RecipeViewModel.self) private var viewModel

    var body: some View {
        List(selection: $selectedCategory) {
            Section {
                ForEach(viewModel.specialCategories, id: \.self) { category in
                    Text(category.title)
                }
            }
        
            Section(header: Text("Categories")) {
                ForEach(viewModel.categories, id: \.self) { category in
                    Text(category.title)
                }
            }
        }
        .listStyle(.sidebar)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                EditButton()
//            }
//            ToolbarItem {
//                Button(action: addItem) {
//                    Label("Add Recipe", systemImage: "plus")
//                }
//            }
//        }
    }

//    private func addItem() {
//        withAnimation {
//            //let newItem = Recipe(title: "\(Date())", ingredients: "Some ingredients", instructions: "Some instructions")
//            //modelContext.insert(newItem)
//            print("Insert item")
//        }
//    }
}
