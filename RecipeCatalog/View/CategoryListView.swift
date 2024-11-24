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
    @State private var showCategoryForm = false
    @Environment(RecipeViewModel.self) private var viewModel

    var body: some View {
        List(selection: $selectedCategory) {
            Section(header: Text("Essentials")){
                ForEach(viewModel.specialCategories, id: \.self) { category in
                    Text(category.title)
                }
            }
        
            Section(header: Text("All Categories")) {
                ForEach(viewModel.categories.filter {
                    searchString.isEmpty || $0.title.localizedCaseInsensitiveContains(searchString)
                }
                .sorted(by: { $0.title < $1.title }), id: \.self) { category in
                    Text(category.title)
                }
            }
        }
        .listStyle(.sidebar)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    showCategoryForm = true
                }) {
                    Label("New Category", systemImage: "folder.badge.plus")
                }
            }
        }
        .sheet(isPresented: $showCategoryForm) {
            CategoryForm()
        }
        .searchable(text: $searchString, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search (categories)")
    }
}
