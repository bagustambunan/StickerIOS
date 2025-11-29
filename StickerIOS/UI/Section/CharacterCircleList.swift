//
//  CharacterListView.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 06/06/25.
//

import SwiftUI

struct CharacterCircleList: View {
    let characters: [Character]
    let selectedCharacter: Character
    let handleTapOnCharacter: (Character) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(characters) { character in
                        CharacterCircleItem(
                            character: character,
                            isSelected: character.identifer == selectedCharacter.identifer,
                            handleTap: { character in
                                handleTapOnCharacter(character)
                            }
                        )
                    }
                }
            }
            CharacterDetail(character: selectedCharacter, hideCharacterName: false)
        }
    }
}

#Preview {
    CharacterCircleList(characters: [], selectedCharacter: CharacterManager.getEmptyCharacter(id: 1)) { Character
        in
    }
}
