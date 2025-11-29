//
//  CarouselView.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 20/06/25.
//

import SwiftUI

struct Carousel: View {
    let favorites: [String]
    let allStickerPacks: [StickerPack]
    let fetchFavorites: () -> Void
    
    @State private var currentIndex = 0
    
    let animatedCategory: Category = Category(identifier: "animated", type: CategoryType.animated, name: "Animated", emoji: "▶️")
    let popularCategory: Category = Category(identifier: "popular", type: CategoryType.emoji, name: "Popular", emoji: "🔥")
    
    var body: some View {
        VStack(spacing: 8) {
            TabView(selection: $currentIndex) {
                
                Link(destination: URL(string: "https://www.instagram.com/duduufriends/")!) {
                    ZStack {
                        Rectangle()
                            .fill(Colors.Accent.opacity(0.3))
                        HStack {
                            Image("Splash")
                                .resizable()
                                .frame(width: 110, height: 110)
                            Text("Follow us on Instagram")
                                .foregroundColor(Color.blue.opacity(0.5))
                        }
                    }
                }
                .tag(0)
                
                NavigationLink(destination: CategoryDetailPage(favorites: favorites, allStickerPacks: allStickerPacks, selectedCategory: popularCategory, fetchFavorites: fetchFavorites)) {
                    ZStack {
                        Rectangle()
                            .fill(Colors.CounterAccent.opacity(0.3))
                        VStack {
                            Text("🔥 Popular")
                                .font(.title)
                                .foregroundColor(Color.black.opacity(0.7))
                            Text("Check our most popular stickers")
                                .foregroundColor(Color.orange)
                        }
                    }
                }
                .tag(1)
                    
                NavigationLink(destination: CategoryDetailPage(favorites: favorites, allStickerPacks: allStickerPacks, selectedCategory: animatedCategory, fetchFavorites: fetchFavorites)) {
                    ZStack {
                        Rectangle()
                            .fill(Color.purple.opacity(0.2))
                        VStack {
                            Text("▶️ Animated")
                                .font(.title)
                                .foregroundColor(Color.black.opacity(0.7))
                            Text("Check our cool animated stickers")
                                .foregroundColor(Color.purple.opacity(0.7))
                        }
                    }
                }
                .tag(2)
                    
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 140)
            .cornerRadius(16)
            
            HStack(spacing: 8) {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(currentIndex == index ? Colors.Accent : Color.gray.opacity(0.5))
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.top, 4)
        }
    }
}

#Preview {
    Carousel(favorites: [], allStickerPacks: []) {
        
    }
}
