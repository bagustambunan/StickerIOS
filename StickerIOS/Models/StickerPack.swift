//
//  StickerPack.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 04/06/25.
//

class StickerPack: Identifiable {
    // To send to WhatsApp
    let identifier: String
    let name: String
    let publisher: String
    let trayImage: ImageData
    let animated: Bool
    var stickers: [Sticker]

    // Only for display
    let characterIdentifier: String
    let mainImage: ImageData
    let description: String
    let emojis: [String]
    var isFavorite: Bool
    
    var id: String { identifier }
    
    init(identifier: String, name: String, publisher: String, trayImageFileName: String, animated: Bool, characterIdentifier: String, mainImageFileName: String, description: String, emojis: [String]) throws {
        guard !name.isEmpty && !publisher.isEmpty && !identifier.isEmpty else {
            throw StickerPackError.emptyString
        }

        guard name.count <= Limits.MaxCharLimit128 && publisher.count <= Limits.MaxCharLimit128 && identifier.count <= Limits.MaxCharLimit128 else {
            throw StickerPackError.stringTooLong
        }
        
        self.identifier = identifier
        self.name = name
        self.publisher = publisher
        self.animated = animated

        self.characterIdentifier = characterIdentifier
        self.description = description
        self.emojis = emojis
        self.isFavorite = false
        
        let trayCompliantImageData: ImageData = try ImageData.imageDataIfCompliant(contentsOfFile: trayImageFileName, imageType: ImageType.tray)
        self.trayImage = trayCompliantImageData
        let mainCompliantImageData: ImageData = try ImageData.imageDataIfCompliant(contentsOfFile: mainImageFileName, imageType: ImageType.main)
        self.mainImage = mainCompliantImageData
        
        self.stickers = []
    }
    
    func toggleIsFavorite() {
        self.isFavorite = !self.isFavorite
    }
    
    func addSticker(
        filename: String, emojis: [String], accessibilityText: String
    ) throws {
        guard stickers.count <= Limits.MaxStickersPerPack else {
            throw StickerPackError.stickersNumOutsideAllowableRange
        }

        let sticker: Sticker = try Sticker(
            filename: filename, emojis: emojis, accessibilityText: accessibilityText
        )

        guard sticker.imageData.animated == self.animated else {
            if self.animated {
                throw StickerPackError.animatedStickerPackWithStaticStickers
            } else {
                throw StickerPackError.staticStickerPackWithAnimatedStickers
            }
        }

        stickers.append(sticker)
    }
    
    func sendToWhatsApp(completionHandler: @escaping (String) -> Void) {
        StickerPackManager.queue.async {
            var json: [String: Any] = [:]
            json["identifier"] = self.identifier
            json["name"] = self.name
            json["publisher"] = self.publisher
            json["tray_image"] = self.trayImage.image!.pngData()?.base64EncodedString()
            if self.animated {
                json["animated_sticker_pack"] = self.animated
            }

            var stickersArray: [[String: Any]] = []
            for sticker in self.stickers {
                var stickerDict: [String: Any] = [:]

                if let imageData = sticker.imageData.webpData {
                    stickerDict["image_data"] = imageData.base64EncodedString()
                } else {
                    print("Skipping bad sticker data")
                    continue
                }

                stickerDict["emojis"] = sticker.emojis
                stickerDict["accessibility_text"] = sticker.accessibilityText

                stickersArray.append(stickerDict)
            }
            json["stickers"] = stickersArray

            let result = ConnectionManager.send(json: json)
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }
}
