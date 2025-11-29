//
//  PrimaryButton.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 06/06/25.
//

import SwiftUI

struct SecondaryButton: View {
    let text: String
    let isFullWidth: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            SecondaryButtonText(text: text, isFullWidth: isFullWidth)
        }
    }
}

#Preview {
    SecondaryButton(text: "", isFullWidth: false) {
        
    }
}
