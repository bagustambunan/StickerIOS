//
//  SecondaryButtonText.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 16/06/25.
//

import SwiftUI

struct SecondaryButtonText: View {
    let text: String
    let isFullWidth: Bool
    
    var body: some View {
        Text(text)
            .foregroundColor(Colors.CounterAccent)
            .padding(12)
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Colors.CounterAccent, lineWidth: 1.5)
            )
    }
}

#Preview {
    SecondaryButtonText(text: "", isFullWidth: false)
}
