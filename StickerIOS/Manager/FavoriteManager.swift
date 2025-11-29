//
//  FavoriteManager.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 07/06/25.
//

class FavoriteManager {
    static func saveToFavoriteTo(_ identifier: String) {
        var favorites = UserDefaults.standard.stringArray(forKey: "FavoriteStickerPacks") ?? []
        if !favorites.contains(identifier) {
            favorites.append(identifier)
            UserDefaults.standard.set(favorites, forKey: "FavoriteStickerPacks")
        }
    }
    
    static func removeFromFavorite(_ identifier: String) {
        var favorites = UserDefaults.standard.stringArray(forKey: "FavoriteStickerPacks") ?? []
        favorites.removeAll { $0 == identifier }
        UserDefaults.standard.set(favorites, forKey: "FavoriteStickerPacks")
    }
    
    static func getFavoriteStickerPacks() -> [String] {
        let favorites = UserDefaults.standard.stringArray(forKey: "FavoriteStickerPacks") ?? []
        return favorites
    }
    
    static func checkIsFavorite(_ identifier: String) -> Bool {
        let favorites = UserDefaults.standard.stringArray(forKey: "FavoriteStickerPacks") ?? []
        return favorites.contains(identifier)
    }
}
