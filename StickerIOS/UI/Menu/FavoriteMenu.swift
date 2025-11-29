//
//  FavoriteMenu.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 21/06/25.
//

import SwiftUI

struct FavoriteMenu: View {
    let favorites: [String]
    let allStickerPacks: [StickerPack]
    let fetchFavorites: () -> Void
    
    let favoriteCategory: Category = Category(identifier: "favorite", type: CategoryType.favorite, name: "Favorite", emoji: "❤️")
    
    var body: some View {
        NavigationView {
            CategoryDetailPage(favorites: favorites, allStickerPacks: allStickerPacks, selectedCategory: favoriteCategory, fetchFavorites: fetchFavorites)
        }
    }
}

#Preview {
    FavoriteMenu(favorites: [], allStickerPacks: []) {
        
    }
}
