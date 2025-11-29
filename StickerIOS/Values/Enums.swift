//
//  Enums.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 04/06/25.
//

enum ImageDataExtension: String {
    case png = "png"
    case webp = "webp"
}

enum StickerPackError: Error {
    case fileNotFound
    case emptyString
    case unsupportedImageFormat(String)
    case imageTooBig(Int64, Bool) // Bool value indicates whether the image is animated
    case invalidImage
    case incorrectImageSize(CGSize)
    case animatedImagesNotSupported
    case stickersNumOutsideAllowableRange
    case stringTooLong
    case tooManyEmojis
    case minFrameDurationTooShort(Double)
    case totalAnimationDurationTooLong(Double)
    case animatedStickerPackWithStaticStickers
    case staticStickerPackWithAnimatedStickers
    case staticStickerAccessibilityTextTooLong
    case animatedStickerAccessibilityTextTooLong
}

enum ImageType: String {
    case normal = "normal"
    case tray = "tray"
    case main = "main"
}

enum CategoryType: String {
    case favorite = "favorite"
    case animated = "animated"
    case emoji = "emoji"
}
