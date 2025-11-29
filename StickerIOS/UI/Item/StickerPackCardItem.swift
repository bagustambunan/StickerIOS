//
//  StickerListItemView.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 02/06/25.
//

import SwiftUI

struct StickerPackCardItem: View {
    @State private var isSendingToWhatsApp = false
    @State private var msg = ""
    @State private var isFavorite: Bool = false
    
    let stickerPack: StickerPack
    let fetchFavorites: () -> Void
    
    var AddToFavoritesButton: some View {
        Button(action: {
            if !self.isFavorite {
                self.isFavorite = true
                FavoriteManager.saveToFavoriteTo(stickerPack.identifier)
            } else {
                self.isFavorite = false
                FavoriteManager.removeFromFavorite(stickerPack.identifier)
            }
            fetchFavorites()
        }) {
            HStack {
                Image(systemName: self.isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(Colors.CounterAccent)
                Text(self.isFavorite ? "Remove from Favorites" : "Add to Favorites")
                    .foregroundColor(Colors.TextForeground)
            }
        }
    }
    
    var AddToWhatsAppButton: some View {
        Button(action: {
            isSendingToWhatsApp = true
            stickerPack.sendToWhatsApp { result in
                if (result == "") {
                    isSendingToWhatsApp = false
                }
                if (result != "") {
                    isSendingToWhatsApp = false
                    msg = result
                }
            }
        }) {
            HStack {
                Image(systemName: "message")
                    .foregroundColor(Colors.CounterAccent)
                Text("Add to WhatsApp")
                    .foregroundColor(Colors.TextForeground)
            }
        }
    }
    
    var popUpContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(stickerPack.name)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(Colors.TextForeground)
                }
            }
            
            AddToFavoritesButton
            AddToWhatsAppButton

//                if isSendingToWhatsApp {
//                    HStack {
//                        ProgressView()
//                            .scaleEffect(0.8)
//                        Text("Sending to WhatsApp...")
//                            .foregroundColor(Colors.TextForeground)
//                    }
//                }
//
//                if msg != "" {
//                    Text(msg)
//                        .font(.caption)
//                        .foregroundColor(.red)
//                        .padding(.horizontal, 8)
//                }
        }
    }
    
    var content: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
            
            HStack(spacing: 12) {
                Image(uiImage: stickerPack.mainImage.image!)
                    .resizable()
                    .frame(width: 64, height: 64)
                VStack(alignment: .leading, spacing: 8) {
                    Text(stickerPack.name)
                        .font(.system(size: 14))
                        .foregroundColor(Color.black.opacity(0.7))
                    HStack {
                        if (isFavorite) {
                            Text("❤️")
                                .font(.system(size: 12))
                                .foregroundColor(Colors.TextForeground)
                        }
                        if (stickerPack.animated) {
                            Text("▶️")
                                .font(.system(size: 12))
                                .foregroundColor(Colors.TextForeground)
                        }
                        Text(stickerPack.emojis.joined(separator: " "))
                            .font(.system(size: 12))
                            .foregroundColor(Colors.TextForeground)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var body: some View {
        Menu {
            popUpContent
        } label: {
            content
        }
        .onAppear {
            loadFavoriteStatus()
        }
    }
    
    private func loadFavoriteStatus() {
        self.isFavorite = FavoriteManager.checkIsFavorite(stickerPack.identifier)
    }
}

#Preview {
    StickerPackCardItem(stickerPack: StickerPackManager.getEmptyStickerPack(id: 1)) {
        
    }
}
