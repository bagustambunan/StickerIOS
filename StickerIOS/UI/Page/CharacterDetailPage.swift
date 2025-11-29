//
//  CharacterOverviewView.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 16/06/25.
//

import SwiftUI

struct CharacterDetailPage: View {
    let character: Character
    let allStickerPacks: [StickerPack]
    let fetchFavorites: () -> Void
    
    @State private var filteredStickerPacks: [StickerPack] = []
    
    var content: some View {
        VStack {
            CharacterDetail(character: character, hideCharacterName: true)
            StickerPackCardList(filteredStickerPacks: filteredStickerPacks, emptyText: "", fetchFavorites: fetchFavorites)
        }
    }
    
    var body: some View {
        PageWrapper(pageTitle: character.name) {
            content
        }
        .onAppear() {
            filterStickerPacksByCharacter(character)
        }
    }
    
    private func filterStickerPacksByCharacter(_ character: Character) {
        self.filteredStickerPacks = self.allStickerPacks.filter { stickerPack in
            return stickerPack.characterIdentifier.lowercased() == character.identifer.lowercased()
        }
    }
}

#Preview {
    NavigationView {
        CharacterDetailPage(character: CharacterManager.getEmptyCharacter(id: 1), allStickerPacks: []) {
            
        }
    }
}
