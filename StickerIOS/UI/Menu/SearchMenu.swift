//
//  SearchView.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 17/06/25.
//

import SwiftUI
import UIKit

struct SearchMenu: View {
    let favorites: [String]
    let allStickerPacks: [StickerPack]
    let fetchFavorites: () -> Void
    
    @State private var filteredStickerPacks: [StickerPack] = []
    @State private var searchText: String = ""
    @State private var isKeyboardVisible: Bool = false
    
    var searchBox: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .font(.system(size: 16, weight: .medium))
            
            TextField("Search stickers...", text: $searchText)
                .font(.system(size: 16))
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color(.white))
        .cornerRadius(12)
    }
    
    var content: some View {
        VStack() {
            HStack {
                searchBox
                if isKeyboardVisible {
                    Button(action: {
                        hideKeyboard()
                    }) {
                        PrimaryButtonText(text: "Search", isFullWidth: false)
                    }
                }
            }
            StickerPackCardList(filteredStickerPacks: filteredStickerPacks, emptyText: "", fetchFavorites: fetchFavorites)
        }
        .onAppear {
            filteredStickerPacks = allStickerPacks
            setupKeyboardNotifications()
        }
        .onDisappear {
            removeKeyboardNotifications()
        }
    }
    
    var body: some View {
        NavigationView {
            PageWrapper(pageTitle: "Search") {
                content
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
        .onChange(of: searchText) { newValue in
            if newValue.isEmpty {
                filteredStickerPacks = allStickerPacks
            } else {
                filteredStickerPacks = allStickerPacks.filter { pack in
                    pack.name.localizedCaseInsensitiveContains(newValue)
                }
            }
        }
    }
    
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) { _ in
            isKeyboardVisible = true
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main) { _ in
            isKeyboardVisible = false
        }
    }
    
    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        isKeyboardVisible = false
    }
}

#Preview {
    SearchMenu(favorites: [], allStickerPacks: []) {
        
    }
}
