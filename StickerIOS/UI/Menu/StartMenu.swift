//
//  StartView.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 06/06/25.
//

import SwiftUI

struct StartMenu: View {
    let isLoading: Bool
    
    let characters: [Character]
    
    let allStickerPacks: [StickerPack]
    let favoriteStickerPacks: [StickerPack]
    
    let favorites: [String]
    let fetchFavorites: () -> Void
    
    var content: some View {
        VStack(spacing: 8) {
            // Section: Carousel
            Carousel(favorites: favorites, allStickerPacks: allStickerPacks, fetchFavorites: fetchFavorites)
                .padding(.bottom, 16)

            if (isLoading) {
                ProgressView()
            } else {
                // Section: Most Liked Characters
                MostLikedCharacterList(characters: characters, allStickerPacks: allStickerPacks, fetchFavorites: fetchFavorites)
                
                // Section: Most Liked Sticker Packs
                SectionWrapper(title: "All Stickers") {
                    StickerPackCardList(filteredStickerPacks: allStickerPacks, emptyText: "No sticker in Most Liked", fetchFavorites: fetchFavorites)
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            PageWrapper(pageTitle: "Sticker IOS") {
                content
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: AboutPage()) {
                        Image(systemName: "info.circle")
                            .foregroundColor(Colors.Accent)
                    }
                }
            }
        }
    }
}

#Preview {
    StartMenu(isLoading: false, characters: [], allStickerPacks: [], favoriteStickerPacks: [], favorites: []) {
        
    }
}
