//
//  CharacterOverviewItem.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 16/06/25.
//

import SwiftUI

struct CharacterCardItem: View {
    @State var index: Int = 0
    
    let character: Character
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                Image(uiImage: character.image.image!)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 8) {
                    Text("#\(index+1)")
                        .font(.system(size: 14))
                        .foregroundColor(Colors.Accent)
                    Text(character.name)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                }
            }
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
        }
    }
}

#Preview {
    CharacterCardItem(index: 0, character: CharacterManager.getEmptyCharacter(id: 1))
}
