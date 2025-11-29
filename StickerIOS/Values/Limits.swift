struct Limits {
    static let MaxStaticStickerFileSize: Int = 100 * 1024
    static let MaxAnimatedStickerFileSize: Int = 500 * 1024
    static let MaxTrayImageFileSize: Int = 50 * 1024

    static let MinAnimatedStickerFrameDurationMS: Int = 8
    static let MaxAnimatedStickerTotalDurationMS: Int = 10000

    static let TrayImageDimensions: CGSize = CGSize(width: 96, height: 96)
    static let MainImageDimensions: CGSize = CGSize(width: 200, height: 200)
    static let ImageDimensions: CGSize = CGSize(width: 512, height: 512)

    static let MinStickersPerPack: Int = 3
    static let MaxStickersPerPack: Int = 30

    static let MaxCharLimit128: Int = 128

    static let MaxEmojisCount: Int = 3
    
    static let MaxStaticStickerAccessibilityTextCharLimit = 125
    static let MaxAnimatedStickerAccessibilityTextCharLimit = 255
}
