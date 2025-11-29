//
//  MainView.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 06/06/25.
//

import SwiftUI

struct AllCharactersPage: View {
    let characters: [Character]
    let allStickerPacks: [StickerPack]
    let fetchFavorites: () -> Void
    
    @State private var selectedCharacter: Character = CharacterManager.getEmptyCharacter(id: 1)
    @State private var filteredStickerPacks: [StickerPack] = []
    
    var content: some View {
        VStack {
            CharacterCircleList(characters: characters, selectedCharacter: selectedCharacter, handleTapOnCharacter: handleTapOnCharacter)
            StickerPackCardList(filteredStickerPacks: filteredStickerPacks, emptyText: "", fetchFavorites: fetchFavorites)
        }
    }
    
    var body: some View {
        PageWrapper(pageTitle: "All Characters") {
            content
        }
        .onAppear() {
            handleTapOnCharacter(characters.first ?? CharacterManager.getEmptyCharacter(id: 1))
        }
    }
    
    private func filterStickerPacksByCharacter(_ character: Character) {
        self.filteredStickerPacks = self.allStickerPacks.filter { stickerPack in
            return stickerPack.characterIdentifier.lowercased() == character.identifer.lowercased()
        }
    }
    
    private func handleTapOnCharacter(_ character: Character) {
        if (character.identifer == selectedCharacter.identifer) {
            return
        }
        self.selectedCharacter = character
        filterStickerPacksByCharacter(character)
    }
}

#Preview {
    NavigationView {
        AllCharactersPage(characters: [], allStickerPacks: []) {
            
        }
    }
}
