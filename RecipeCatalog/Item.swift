//
//  Item.swift
//  RecipeCatalog
//
//  Created by Koleton Murray on 11/12/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
