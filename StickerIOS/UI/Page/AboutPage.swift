//
//  AboutView.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 06/06/25.
//

import SwiftUI

struct AboutPage: View {
    var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Hi there! Thanks for downloading this app. You can add adorable stickers to WhatsApp — and the best part? It's all free! Enjoy!")
                .foregroundColor(Colors.TextForeground)
            Divider()
            
            Text("App version: 1.0")
            Divider()
            
            HStack {
                Text("Made with ❤️ by")
                    .foregroundColor(Colors.TextForeground)
                Link("@bagustambunan", destination: URL(string: "https://www.linkedin.com/in/bagustambunan/")!)
                    .foregroundColor(Colors.Accent)
            }
            Divider()
            
            Link("Privacy Policy 🔒", destination: URL(string: "https://bagustambunan.netlify.app/")!)
                .foregroundColor(Colors.Accent)
            Divider()
            
            Link("Follow us on Instagram 📸", destination: URL(string: "https://www.instagram.com/duduufriends/")!)
                .foregroundColor(Colors.Accent)
        }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .font(.system(size: 16))
    }
    
    var body: some View {
        PageWrapper(pageTitle: "About") {
            content
        }
    }
}

#Preview {
    NavigationView {
        AboutPage()
    }
}
