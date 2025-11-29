//
//  Connection.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 04/06/25.
//

import UIKit

struct ConnectionManager {
    private static let PasteboardExpirationSeconds: TimeInterval = 60
    private static let PasteboardStickerPackDataType: String = "net.whatsapp.third-party.sticker-pack"
    private static let WhatsAppURL: URL = URL(string: "whatsapp://stickerPack")!

    static var iOSAppStoreLink: String?
    static var AndroidStoreLink: String?

    static func checkCanSend() -> Bool {
        return UIApplication.shared.canOpenURL(URL(string: "whatsapp://")!)
    }
    
    static func send(json: [String: Any]) -> String {
        let pasteboard = UIPasteboard.general

        var jsonWithAppStoreLink: [String: Any] = json
        jsonWithAppStoreLink["ios_app_store_link"] = iOSAppStoreLink
        jsonWithAppStoreLink["android_play_store_link"] = AndroidStoreLink

        guard let dataToSend = try? JSONSerialization.data(withJSONObject: jsonWithAppStoreLink, options: []) else {
            return "failed: dataToSend"
        }

        if #available(iOS 10.0, *) {
            pasteboard.setItems([[PasteboardStickerPackDataType: dataToSend]], options: [UIPasteboard.OptionsKey.localOnly: true, UIPasteboard.OptionsKey.expirationDate: NSDate(timeIntervalSinceNow: PasteboardExpirationSeconds)])
        } else {
            pasteboard.setData(dataToSend, forPasteboardType: PasteboardStickerPackDataType)
        }

        DispatchQueue.main.async {
            if checkCanSend() {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(WhatsAppURL)
                } else {
                    UIApplication.shared.openURL(WhatsAppURL)
                }
            }
        }
        return ""
    }
}
