//
//  Sticker.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 04/06/25.
//

class Sticker {
    let imageData: ImageData
    let emojis: [String]
    let accessibilityText: String
    
    init(filename: String, emojis: [String], accessibilityText: String) throws {
        let stickerImageData: ImageData = try ImageData.imageDataIfCompliant(contentsOfFile: filename, imageType: ImageType.normal)
        self.imageData = stickerImageData
        
        self.emojis = emojis
        self.accessibilityText = accessibilityText
    }
}
