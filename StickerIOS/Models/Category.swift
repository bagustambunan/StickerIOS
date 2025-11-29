//
//  Category.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 08/06/25.
//

class Category: Identifiable {
    let identifier: String
    let type: CategoryType
    let name: String
    let emoji: String
    
    var id: String { identifier }
    
    init(identifier: String, type: CategoryType, name: String, emoji: String) {
        self.identifier = identifier
        self.type = type
        self.name = name
        self.emoji = emoji
    }
}
