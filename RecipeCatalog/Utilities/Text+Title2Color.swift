//
//  Text+Title2Color.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/23/24.
//

import Foundation
import SwiftUI

extension Text {
    func title2Style() -> Text {
        self
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundStyle(.darkGreen)
    }
}
