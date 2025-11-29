//
//  CategoryManager.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 21/06/25.
//

class CategoryManager {
    static let queue: DispatchQueue = DispatchQueue(label: "categoryQueue")
    
    static func getEmptyCategory(id: Int) -> Category {
        return Category(identifier: "category\(id)", type: CategoryType.emoji, name: "Category Name", emoji: "😊")
    }
}
