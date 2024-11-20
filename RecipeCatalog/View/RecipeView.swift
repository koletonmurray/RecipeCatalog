//
//  RecipeView.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/12/24.
//

import SwiftUI

struct RecipeView: View {
    let recipe: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(recipe)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)

            Text("Recipe details for \(recipe) go here.")
                .font(.body)
                .padding(.bottom, 20)

            Text("Ingredients")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 5)
            
            Text("• Ingredient 1\n• Ingredient 2\n• Ingredient 3")
                .padding(.bottom, 20)

            Text("Instructions")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 5)
            
            Text("1. Step one\n2. Step two\n3. Step three")
            Spacer()
        }
        .padding()
        //.navigationTitle(recipe)
    }
}

#Preview {
    RecipeView(recipe: "Bruschetta")
}
