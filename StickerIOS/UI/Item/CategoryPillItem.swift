//
//  CategoryListItemView.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 08/06/25.
//

import SwiftUI

struct CategoryPillItem: View {
    let category: Category?
    let isSelected: Bool
    let handleTap: () -> Void
    
    @State private var isPressed = false
    
    var Content: some View {
        Text((category?.emoji ?? "") + " " + (category?.name ?? ""))
            .padding(.horizontal, 10)
            .padding(.vertical, 14)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Colors.Accent : Color.white.opacity(0.7), lineWidth: isSelected ? 4 : 2)
            )
            .scaleEffect(isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: isPressed)
            .onTapGesture {
                isPressed = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isPressed = false
                    handleTap()
                }
            }
    }
    
    var body: some View {
        Content
            .padding(4)
    }
}

#Preview {
    CategoryPillItem(category: nil, isSelected: false) {
        
    }
}
