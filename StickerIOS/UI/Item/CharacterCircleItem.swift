//
//  CharacterListItemView.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 06/06/25.
//

import SwiftUI

struct CharacterCircleItem: View {
    @State private var isPressed = false
    
    let character: Character
    let isSelected: Bool
    let handleTap: (Character) -> Void
    
    var body: some View {
        Image(uiImage: character.image.image!)
            .resizable()
            .frame(width: 68, height: 68)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(isSelected ? Colors.Accent : Color.white.opacity(0.7), lineWidth: isSelected ? 4 : 2)
            )
            .padding(4)
            .scaleEffect(isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: isPressed)
            .onTapGesture {
                isPressed = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isPressed = false
                    handleTap(character)
                }
            }
    }
}

#Preview {
    CharacterCircleItem(character: CharacterManager.getEmptyCharacter(id: 1), isSelected: false) { Character in
        
    }
}
