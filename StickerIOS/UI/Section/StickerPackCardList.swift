//
//  StickerPackListView.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 06/06/25.
//

import SwiftUI

struct StickerPackCardList: View {
    let filteredStickerPacks: [StickerPack]
    let emptyText: String
    let fetchFavorites: () -> Void
    
    var body: some View {
        Group {
            if (filteredStickerPacks.count > 0) {
                VStack(spacing: 16) {
                    ForEach(filteredStickerPacks) { stickerPack in
                        StickerPackCardItem(
                            stickerPack: stickerPack,
                            fetchFavorites: fetchFavorites
                        )
                    }
                }
            } else {
                Text(emptyText)
                    .padding()
            }
        }
    }
}

#Preview {
    StickerPackCardList(filteredStickerPacks: [], emptyText: "Empty") {
        
    }
}
