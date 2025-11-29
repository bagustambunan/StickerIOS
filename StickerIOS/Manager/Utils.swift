//
//  Utils.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 06/06/25.
//

extension Dictionary {
    func bytesSize() -> Int {
        let data: NSMutableData = NSMutableData()
        let encoder: NSKeyedArchiver = NSKeyedArchiver(forWritingWith: data)
        encoder.encode(self, forKey: "dictionary")
        encoder.finishEncoding()

        return data.length
    }
}

struct Utils {
    static func stickersJSON() throws -> [String: Any] {
        if let path = Bundle.main.path(forResource: "sticker_packs", ofType: "json") {
            let data: Data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            return try JSONSerialization.jsonObject(with: data) as! [String: Any]
        }
        throw StickerPackError.fileNotFound
    }
}
