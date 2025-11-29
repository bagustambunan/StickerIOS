//
//  SplashPage.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 21/06/25.
//

import SwiftUI

struct SplashPage: View {
    var content: some View {
        Image("Splash")
            .resizable()
            .frame(width: 160, height: 160)
    }
    
    var body: some View {
        Group {
            if #available(iOS 15.0, *) {
                content
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Colors.Accent)
            } else {
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Colors.Accent)
            }
        }
    }
}

#Preview {
    SplashPage()
}
