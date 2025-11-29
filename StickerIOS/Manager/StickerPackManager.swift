//
//  StickerPackManager.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 04/06/25.
//

class StickerPackManager {

    static let queue: DispatchQueue = DispatchQueue(label: "stickerPackQueue")

    static func fetchStickerPacks(completionHandler: @escaping ([StickerPack]) -> Void) {
        queue.async {
            var dict: [String: Any]
            do {
                dict = try Utils.stickersJSON()
            } catch {
                fatalError(error.localizedDescription)
            }
            
            let stickerPacksFromJson: [[String: Any]] = dict["sticker_packs"] as! [[String: Any]]
            var stickerPacks: [StickerPack] = []
            var currentIdentifiers: [String: Bool] = [:]

            let iosAppStoreLink: String? = dict["ios_app_store_link"] as? String
            let androidAppStoreLink: String? = dict["android_play_store_link"] as? String
            ConnectionManager.iOSAppStoreLink = iosAppStoreLink != "" ? iosAppStoreLink : nil
            ConnectionManager.AndroidStoreLink = androidAppStoreLink != "" ? androidAppStoreLink : nil

            for pack in stickerPacksFromJson {
                let packIdentifier: String = pack["identifier"] as! String
                let packName: String = pack["name"] as! String
                let packPublisher: String = "Duduu Friends"
                let packTrayImageFileName: String = packIdentifier + "_Tray.png"
                let animatedStickerPack: Bool = pack["animated_sticker_pack"] as! Bool
                var stickerPack: StickerPack?

                let packCharacterIdentifier: String = pack["character"] as! String
                let packMainImageFileName: String = packIdentifier + "_Main.png"
                let packDescription: String = pack["description"] as! String
                let packEmojis: [String] = pack["emojis"] as! [String]

                // Pack identifier has to be a valid string and be unique
                if currentIdentifiers[packIdentifier] == nil {
                    currentIdentifiers[packIdentifier] = true
                } else {
                    fatalError("\(packName) must have an identifier and it must be unique.")
                }

                do {
                    stickerPack = try StickerPack(identifier: packIdentifier, name: packName, publisher: packPublisher, trayImageFileName: packTrayImageFileName, animated: animatedStickerPack, characterIdentifier: packCharacterIdentifier, mainImageFileName: packMainImageFileName, description: packDescription, emojis: packEmojis)
                } catch StickerPackError.fileNotFound {
                    fatalError("\(packTrayImageFileName) not found.")
                } catch StickerPackError.emptyString {
                    fatalError("The name, identifier, and publisher strings can't be empty.")
                } catch StickerPackError.unsupportedImageFormat(let imageFormat) {
                    fatalError("\(packTrayImageFileName): \(imageFormat) is not a supported format.")
                } catch StickerPackError.invalidImage {
                    fatalError("Tray image file size is 0 KB.")
                } catch StickerPackError.imageTooBig(let imageFileSize, _) {
                    let roundedSize = round((Double(imageFileSize) / 1024) * 100) / 100;
                    fatalError("\(packTrayImageFileName): \(roundedSize) KB is bigger than the max tray image file size (\(Limits.MaxTrayImageFileSize / 1024) KB).")
                } catch StickerPackError.incorrectImageSize(let imageDimensions) {
                    fatalError("\(packTrayImageFileName): \(imageDimensions) is not compliant with tray dimensions requirements, \(Limits.TrayImageDimensions).")
                } catch StickerPackError.animatedImagesNotSupported {
                    fatalError("\(packTrayImageFileName) is an animated image. Animated images are not supported.")
                } catch StickerPackError.stringTooLong {
                    fatalError("Name, identifier, and publisher of sticker pack must be less than \(Limits.MaxCharLimit128) characters.")
                } catch {
                    fatalError(error.localizedDescription)
                }

                let stickers: [[String: Any]] = pack["stickers"] as! [[String: Any]]
                for sticker in stickers {
                    let emojis: [String] = sticker["emojis"] as! [String]
                    let accessibilityText: String = sticker["accessibility_text"] as! String

                    let filename = sticker["image_file"] as! String
                    do {
                        try stickerPack!.addSticker(
                            filename: filename,
                            emojis: emojis,
                            accessibilityText: accessibilityText
                        )
                    } catch StickerPackError.stickersNumOutsideAllowableRange {
                        fatalError("Sticker count outside the allowable limit (\(Limits.MaxStickersPerPack) stickers per pack).")
                    } catch StickerPackError.fileNotFound {
                        fatalError("\(filename) not found.")
                    } catch StickerPackError.unsupportedImageFormat(let imageFormat) {
                        fatalError("\(filename): \(imageFormat) is not a supported format.")
                    } catch StickerPackError.invalidImage {
                        fatalError("Image file size is 0 KB.")
                    } catch StickerPackError.imageTooBig(let imageFileSize, let animated) {
                        let roundedSize = round((Double(imageFileSize) / 1024) * 100) / 100;
                        let maxSize = animated ? Limits.MaxAnimatedStickerFileSize : Limits.MaxStaticStickerFileSize
                        fatalError("\(filename): \(roundedSize) KB is bigger than the max file size (\(maxSize / 1024) KB).")
                    } catch StickerPackError.incorrectImageSize(let imageDimensions) {
                        fatalError("\(filename): \(imageDimensions) is not compliant with sticker images dimensions, \(Limits.ImageDimensions).")
                    } catch StickerPackError.tooManyEmojis {
                        fatalError("\(filename) has too many emojis. \(Limits.MaxEmojisCount) is the maximum number.")
                    } catch StickerPackError.minFrameDurationTooShort(let minFrameDuration) {
                        let roundedDuration = round(minFrameDuration)
                        fatalError("\(filename): \(roundedDuration) ms is shorter than the min frame duration (\(Limits.MinAnimatedStickerFrameDurationMS) ms).")
                    } catch StickerPackError.totalAnimationDurationTooLong(let totalFrameDuration) {
                        let roundedDuration = round(totalFrameDuration)
                        fatalError("\(filename): \(roundedDuration) ms is longer than the max total animation duration (\(Limits.MaxAnimatedStickerTotalDurationMS) ms).")
                    } catch StickerPackError.animatedStickerPackWithStaticStickers {
                        fatalError("Animated sticker pack contains static stickers.")
                    } catch StickerPackError.staticStickerPackWithAnimatedStickers {
                        fatalError("Static sticker pack contains animated stickers.")
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }

                if stickers.count < Limits.MinStickersPerPack {
                  fatalError("Sticker count smaller that the allowable limit (\(Limits.MinStickersPerPack) stickers per pack).")
                }

                stickerPacks.append(stickerPack!)
            }

            DispatchQueue.main.async {
                completionHandler(stickerPacks)
            }
        }
    }
    
    static func getEmptyStickerPack(id: Int) -> StickerPack {
        var stickerPack: StickerPack
        
        let packIdentifier = "StickerPackIdentifier" + String(id)
        let packName = "Sticker Pack Name"
        let packPublisher = "Publisher Name"
        let packTrayImageFileName = "Cuppy_Tray.png"
        
        let packCharacterIdentifier = "Cuppy"
        let packMainImageFileName = "Cuppy_Main.png"
        let packDescription = "Sticker Pack Description"
        let packEmojis = ["🙂","😍"]
        
        do {
            stickerPack = try StickerPack(identifier: packIdentifier, name: packName, publisher: packPublisher, trayImageFileName: packTrayImageFileName, animated: true, characterIdentifier: packCharacterIdentifier, mainImageFileName: packMainImageFileName, description: packDescription, emojis: packEmojis)
        } catch StickerPackError.fileNotFound {
            fatalError("\(packTrayImageFileName) not found.")
        } catch StickerPackError.emptyString {
            fatalError("The name, identifier, and publisher strings can't be empty.")
        } catch StickerPackError.unsupportedImageFormat(let imageFormat) {
            fatalError("\(packTrayImageFileName): \(imageFormat) is not a supported format.")
        } catch StickerPackError.invalidImage {
            fatalError("Tray image file size is 0 KB.")
        } catch StickerPackError.imageTooBig(let imageFileSize, _) {
            let roundedSize = round((Double(imageFileSize) / 1024) * 100) / 100;
            fatalError("\(packTrayImageFileName): \(roundedSize) KB is bigger than the max tray image file size (\(Limits.MaxTrayImageFileSize / 1024) KB).")
        } catch StickerPackError.incorrectImageSize(let imageDimensions) {
            fatalError("\(packTrayImageFileName): \(imageDimensions) is not compliant with tray dimensions requirements, \(Limits.TrayImageDimensions).")
        } catch StickerPackError.animatedImagesNotSupported {
            fatalError("\(packTrayImageFileName) is an animated image. Animated images are not supported.")
        } catch StickerPackError.stringTooLong {
            fatalError("Name, identifier, and publisher of sticker pack must be less than \(Limits.MaxCharLimit128) characters.")
        } catch {
            fatalError(error.localizedDescription)
        }
        
        return stickerPack;
    }

}
