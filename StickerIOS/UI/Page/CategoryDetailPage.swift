//
//  CategoryDetailPage.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 20/06/25.
//

import SwiftUI

struct CategoryDetailPage: View {
    let favorites: [String]
    let allStickerPacks: [StickerPack]
    let selectedCategory: Category
    let fetchFavorites: () -> Void
    
    @State private var filteredStickerPacks: [StickerPack] = []
    
    var content: some View {
        StickerPackCardList(filteredStickerPacks: filteredStickerPacks, emptyText: selectedCategory.identifier == "favorite" ? "Your favorite stickers will be displayed here" : "No sticker in " + (selectedCategory.name), fetchFavorites: fetchFavorites)
    }
    
    var body: some View {
        PageWrapper(pageTitle: "\(selectedCategory.name) Stickers") {
            content
        }
        .onAppear {
            loadStickerPacksByCategory(selectedCategory)
        }
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
    
    private func loadStickerPacksByCategory(_ category: Category) {
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
        CategoryDetailPage(favorites: [], allStickerPacks: [], selectedCategory: CategoryManager.getEmptyCategory(id: 1)) {
            
        }
    }
}
