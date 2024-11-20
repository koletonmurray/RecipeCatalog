//
//  ContentView.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/12/24.
//

import SwiftUI

struct AppView: View {
    @State var hasSeenWelcome = false
    @Environment(RecipeViewModel.self) private var viewModel

    var body: some View {
        if hasSeenWelcome {
            MainView()
        } else {
            WelcomeView(hasSeenWelcome: $hasSeenWelcome)
        }
    }
}
