//
//  CharacterDetailView.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 07/06/25.
//

import SwiftUI

struct CharacterDetail: View {
    let character: Character
    let hideCharacterName: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(spacing: 16) {
                Image(uiImage: character.image.image!)
                    .resizable()
                    .cornerRadius(16)
                    .frame(width: 100, height: 100)
                if (!hideCharacterName) {
                    Text(character.name)
                        .font(.headline)
                        .foregroundColor(Colors.TextForeground)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            Text(character.description)
                .font(.system(size: 14))
                .foregroundColor(Color.black.opacity(0.7))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
    }
}

#Preview {
    CharacterDetail(character: CharacterManager.getEmptyCharacter(id: 1), hideCharacterName: false)
}
