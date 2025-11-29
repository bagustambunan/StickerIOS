//
//  CategoryListView.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 08/06/25.
//

import SwiftUI

struct CategoryPillList: View {
    let categories: [Category]
    let selectedCategory: Category?
    let handleTapOnCategory: (Category) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(categories) { category in
                    CategoryPillItem(category: category, isSelected: category.identifier == selectedCategory?.identifier) {
                        handleTapOnCategory(category)
                    }
                }
            }
        }
    }
}

#Preview {
    CategoryPillList(categories: [], selectedCategory: nil) { Category in
        
    }
}
