//
//  MostLikedCharacterList.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 21/06/25.
//

import SwiftUI

struct MostLikedCharacterList: View {
    let characters: [Character]
    let allStickerPacks: [StickerPack]
    let fetchFavorites: () -> Void
    
    var body: some View {
        SectionWrapper(title: "Most Liked Characters") {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(characters.prefix(3)) { character in
                    NavigationLink(destination: CharacterDetailPage(character: character, allStickerPacks: allStickerPacks, fetchFavorites: fetchFavorites)) {
                        CharacterCardItem(index: characters.firstIndex(of: character) ?? 0, character: character)
                    }
                }
                NavigationLink(destination: AllCharactersPage(characters: characters, allStickerPacks: allStickerPacks, fetchFavorites: fetchFavorites)) {
                    PrimaryButtonText(text: "🐻 🐱 🐼 See All Characters", isFullWidth: true)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
        }
    }
}

#Preview {
    MostLikedCharacterList(characters: [], allStickerPacks: []) {
        
    }
}
