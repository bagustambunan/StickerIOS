//
//  ImageData.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 04/06/25.
//

import Foundation

extension CGSize {

    public static func ==(left: CGSize, right: CGSize) -> Bool {
        return left.width.isEqual(to: right.width) && left.height.isEqual(to: right.height)
    }

    public static func <(left: CGSize, right: CGSize) -> Bool {
        return left.width.isLess(than: right.width) && left.height.isLess(than: right.height)
    }

    public static func >(left: CGSize, right: CGSize) -> Bool {
        return !left.width.isLessThanOrEqualTo(right.width) && !left.height.isLessThanOrEqualTo(right.height)
    }

    public static func <=(left: CGSize, right: CGSize) -> Bool {
        return left.width.isLessThanOrEqualTo(right.width) && left.height.isLessThanOrEqualTo(right.height)
    }

    public static func >=(left: CGSize, right: CGSize) -> Bool {
        return !left.width.isLess(than: right.width) && !left.height.isLess(than: right.height)
    }

}

class ImageData {
    let data: Data
    let type: ImageDataExtension

    var bytesSize: Int64 {
        return Int64(data.count)
    }

    lazy var animated: Bool = {
        if type == .webp {
            return WebPManager.shared.isAnimated(webPData: data)
        } else {
            return false
        }
    }()

    lazy var minFrameDuration: Double = {
        return WebPManager.shared.minFrameDuration(webPData: data) * 1000
    }()

    lazy var totalAnimationDuration: Double = {
        return WebPManager.shared.totalAnimationDuration(webPData: data) * 1000
    }()

    lazy var webpData: Data? = {
        if type == .webp {
            return data
        } else {
            return WebPManager.shared.encode(pngData: data)
        }
    }()

    lazy var image: UIImage? = {
        if type == .webp {
            guard let images = WebPManager.shared.decode(webPData: data) else {
                return nil
            }
            if images.count == 0 {
                return nil
            }
            if images.count == 1 {
                return images.first
            }
            return UIImage.animatedImage(with: images, duration: WebPManager.shared.totalAnimationDuration(webPData: data))
        } else {
            // Static image
            return UIImage(data: data)
        }
    }()

    func image(withSize size: CGSize) -> UIImage? {
        guard let image = image else { return nil }

        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        image.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }

    init(data: Data, type: ImageDataExtension) {
        self.data = data
        self.type = type
    }

    static func imageDataIfCompliant(contentsOfFile filename: String, imageType: ImageType) throws -> ImageData {
        let fileExtension: String = (filename as NSString).pathExtension

        guard let imageURL = Bundle.main.url(forResource: filename, withExtension: "") else {
            throw StickerPackError.fileNotFound
        }

        let data = try Data(contentsOf: imageURL)
        guard let extensionType = ImageDataExtension(rawValue: fileExtension) else {
            throw StickerPackError.unsupportedImageFormat(fileExtension)
        }

        return try ImageData.imageDataIfCompliant(rawData: data, extensionType: extensionType, imageType: imageType, fileName: filename)
    }

    static func imageDataIfCompliant(rawData: Data, extensionType: ImageDataExtension, imageType: ImageType, fileName: String? = nil) throws -> ImageData {
        let imageData = ImageData(data: rawData, type: extensionType)
        let isAnimated = imageData.animated

        guard imageData.bytesSize > 0 else {
            throw StickerPackError.invalidImage
        }
        if imageType == ImageType.tray {
            guard !imageData.animated else {
                throw StickerPackError.animatedImagesNotSupported
            }

            guard imageData.bytesSize <= Limits.MaxTrayImageFileSize else {
                throw StickerPackError.imageTooBig(imageData.bytesSize, false)
            }

            guard imageData.image!.size == Limits.TrayImageDimensions else {
                throw StickerPackError.incorrectImageSize(imageData.image!.size)
            }
        } else {
            guard (isAnimated && imageData.bytesSize <= Limits.MaxAnimatedStickerFileSize) ||
                    (!isAnimated && imageData.bytesSize <= Limits.MaxStaticStickerFileSize) else {
                throw StickerPackError.imageTooBig(imageData.bytesSize, isAnimated)
            }

            guard imageData.image!.size == (imageType == ImageType.main ? Limits.MainImageDimensions : Limits.ImageDimensions) else {
                throw StickerPackError.incorrectImageSize(imageData.image!.size)
            }

            if isAnimated {
                guard imageData.minFrameDuration >= Double(Limits.MinAnimatedStickerFrameDurationMS) else {
                    throw StickerPackError.minFrameDurationTooShort(imageData.minFrameDuration)
                }

                guard imageData.totalAnimationDuration <= Double(Limits.MaxAnimatedStickerTotalDurationMS) else {
                    throw StickerPackError.totalAnimationDurationTooLong(imageData.totalAnimationDuration)
                }
            }
        }

        return imageData
    }
}
