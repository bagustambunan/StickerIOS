//
//  PrimaryButtonText.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 16/06/25.
//

import SwiftUI

struct PrimaryButtonText: View {
    let text: String
    let isFullWidth: Bool
    
    var body: some View {
        Text(text)
            .foregroundColor(Color.white)
            .padding(12)
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .background(Colors.Accent)
            .cornerRadius(8)
    }
}

#Preview {
    PrimaryButtonText(text: "", isFullWidth: false)
}
