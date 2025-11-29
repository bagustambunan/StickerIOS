//
//  PrimaryButton.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 06/06/25.
//

import SwiftUI

struct PrimaryButton: View {
    let text: String
    let isFullWidth: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            PrimaryButtonText(text: text, isFullWidth: isFullWidth)
        }
    }
}

#Preview {
    PrimaryButton(text: "", isFullWidth: false) {
        
    }
}
