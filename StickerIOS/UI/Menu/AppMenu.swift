//
//  MenuView.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 17/06/25.
//

import SwiftUI

struct AppMenu: View {
    @State private var favorites: [String] = []
    
    @State private var isLoadingCharacters = false
    @State private var characters: [Character] = []
    
    @State private var isLoadingStickerPacks = false
    @State private var allStickerPacks: [StickerPack] = []
    
    @State private var favoriteStickerPacks: [StickerPack] = []
    
    @State private var showSplash = true
    
    var tabView: some View {
        TabView {
            StartMenu(isLoading: isLoadingCharacters || isLoadingStickerPacks, characters: characters, allStickerPacks: allStickerPacks, favoriteStickerPacks: favoriteStickerPacks, favorites: favorites, fetchFavorites: fetchFavorites)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            SearchMenu(favorites: favorites, allStickerPacks: allStickerPacks, fetchFavorites: fetchFavorites)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            FavoriteMenu(favorites: favorites, allStickerPacks: allStickerPacks, fetchFavorites: fetchFavorites)
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorite")
                }
        }
    }
    
    var body: some View {
        Group {
            if showSplash {
                SplashPage()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                tabView
            }
        }
            .accentColor(Colors.Accent)
            .preferredColorScheme(.light)
            .onAppear {
                fetchFavorites()
                fetchCharacters()
                fetchStickerPacks()
            }
    }
    
    private func fetchFavorites() {
        self.favorites = FavoriteManager.getFavoriteStickerPacks()
    }
    
    private func fetchCharacters() {
        isLoadingCharacters = true
        
        CharacterManager.fetchCharacters() { characters in
            DispatchQueue.main.async {
                self.characters = characters
                self.isLoadingCharacters = false
            }
        }
    }
    
    private func fetchStickerPacks() {
        isLoadingStickerPacks = true
        
        StickerPackManager.fetchStickerPacks() { stickerPacks in
            DispatchQueue.main.async {
                self.allStickerPacks = stickerPacks
                self.filterFavoriteStickerPacks()
                self.isLoadingStickerPacks = false
            }
        }
    }
    
    private func filterFavoriteStickerPacks() {
        self.favoriteStickerPacks = self.allStickerPacks.filter({ stickerPack in
            self.favorites.contains(stickerPack.identifier)
        })
    }
}

#Preview {
    AppMenu()
}
