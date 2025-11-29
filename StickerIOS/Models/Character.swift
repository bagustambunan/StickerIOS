//
//  Character.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 06/06/25.
//

class Character: Identifiable, Equatable {
    let identifer: String
    let name: String
    let image: ImageData
    let description: String
    
    var id: String { identifer }
    
    init(identifier: String, name: String, imageFileName: String, description: String) throws {
        self.identifer = identifier
        self.name = name
        
        let imageData: ImageData = try ImageData.imageDataIfCompliant(contentsOfFile: imageFileName, imageType: ImageType.main)
        self.image = imageData
        
        self.description = description
    }
    
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.identifer == rhs.identifer
    }
}
