//
//  WelcomeScreen.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/12/24.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var hasSeenWelcome: Bool

    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Image("RecipeLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
            
            Text("Sizzle & Stir")
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .foregroundStyle(.alwaysDarkGreen)
            
            Text("your digital recipe book")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(.darkPurple)
            
            Spacer()
            
            Button(action: {
                hasSeenWelcome = true
            }) {
                HStack {
                    Text("Let's Cook!")
                    Image(systemName: "arrow.right")
                }
                    .font(.system(size: 32, weight: .medium, design: .rounded))
                    .padding()
                    .background(Color.alwaysDarkGreen)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom, 40)
            
            Spacer()
            
            Text("© Koleton Murray")
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.alwaysDarkGreen)
                .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.alwaysBackgroundTan)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    WelcomeView(hasSeenWelcome: .constant(false))
}
