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
                    HStack {
                        if !category.sfSymbol.isEmpty {
                            Image(systemName: category.sfSymbol)
                                .foregroundStyle(category.symbolColor == "red" ? .darkRed : .darkGreen)
                                .frame(width: 28, height: 28, alignment: .center)
                        }
                        Text(category.title)
                        Spacer()
                    }
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
                    Image(systemName: "folder.badge.plus")
                        .foregroundStyle(.primary)
                }
            }
        }
        .sheet(isPresented: $showCategoryForm) {
            CategoryForm()
        }
        .searchable(text: $searchString, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search (categories)")
    }
}
