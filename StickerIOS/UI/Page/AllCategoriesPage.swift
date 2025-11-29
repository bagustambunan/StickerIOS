//
//  AllCategoriesView.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 08/06/25.
//

import SwiftUI

struct AllCategoriesPage: View {
    let favorites: [String]
    let allStickerPacks: [StickerPack]
    let fetchFavorites: () -> Void
    
    @State private var categories: [Category] = []
    @State private var selectedCategory: Category? = nil
    @State private var filteredStickerPacks: [StickerPack] = []
    
    var content: some View {
        VStack {
            CategoryPillList(categories: categories, selectedCategory: selectedCategory, handleTapOnCategory: handleTapOnCategory(_:))
            StickerPackCardList(filteredStickerPacks: filteredStickerPacks, emptyText: "No sticker in " + (selectedCategory?.name ?? ""), fetchFavorites: fetchFavorites)
        }
    }
    
    var body: some View {
        PageWrapper(pageTitle: "All Categories") {
            content
        }
        .onAppear {
            loadCategories()
            handleTapOnFavoriteCategory()
        }
    }
    
    private func loadCategories() {
        let favoriteCategory: Category = Category(identifier: "favorite", type: CategoryType.favorite, name: "Favorite", emoji: "❤️")
        let animatedCategory: Category = Category(identifier: "animated", type: CategoryType.animated, name: "Animated", emoji: "▶️")
        let hotCategory: Category = Category(identifier: "hot", type: CategoryType.emoji, name: "Hot", emoji: "🔥")
        self.categories = [favoriteCategory, animatedCategory, hotCategory]
        self.selectedCategory = favoriteCategory
    }
    
    private func handleTapOnFavoriteCategory() {
        self.filteredStickerPacks = self.allStickerPacks.filter({ stickerPack in
            self.favorites.contains(stickerPack.identifier)
        })
    }
    
    private func handleTapOnAnimatedCategory() {
        self.filteredStickerPacks = self.allStickerPacks.filter({ stickerPack in
            stickerPack.animated
        })
    }
    
    private func handleTapOnEmojiCategory(_ emoji: String) {
        self.filteredStickerPacks = self.allStickerPacks.filter({ stickerPack in
            stickerPack.emojis.contains(emoji)
        })
    }
    
    private func handleTapOnCategory(_ category: Category) {
        self.selectedCategory = category
        if (category.identifier == "favorite") {
            self.handleTapOnFavoriteCategory()
        } else if (category.identifier == "animated") {
            self.handleTapOnAnimatedCategory()
        } else {
            self.handleTapOnEmojiCategory(category.emoji)
        }
    }
}

#Preview {
    NavigationView {
        AllCategoriesPage(favorites: [], allStickerPacks: []) {
            
        }
    }
}

