//
//  CharacterManager.swift
//  StickerIOS
//
//  Created by Muhammad Bagus Syahputra Tambunan on 06/06/25.
//

class CharacterManager {
    
    static let queue: DispatchQueue = DispatchQueue(label: "characterQueue")
    
    static func fetchCharacters(completionHandler: @escaping ([Character]) -> Void) {
        queue.async {
            var dict: [String: Any]
            do {
                dict = try Utils.stickersJSON()
            } catch {
                fatalError(error.localizedDescription)
            }
            
            let charactersFromJson: [[String: Any]] = dict["characters"] as! [[String: Any]]
            var characters: [Character] = []

            for character in charactersFromJson {
                let characterIdentifier: String = character["identifier"] as! String
                let characterName: String = character["name"] as! String
                let characterImage: String = character["image"] as! String
                let characterDescription: String = character["description"] as! String

                do {
                    let createdCharacter: Character = try Character(identifier: characterIdentifier, name: characterName, imageFileName: characterImage, description: characterDescription)
                    characters.append(createdCharacter)
                } catch StickerPackError.fileNotFound {
                    fatalError("Warning: Character image not found for \(characterName): \(characterImage)")
                } catch StickerPackError.unsupportedImageFormat(let format) {
                    fatalError("Warning: Unsupported image format for \(characterName): \(format)")
                } catch StickerPackError.imageTooBig(let size, _) {
                    fatalError("Warning: Image too big for \(characterName): \(size) bytes")
                } catch StickerPackError.incorrectImageSize(let size) {
                    fatalError("Warning: Incorrect image size for \(characterName): \(size)")
                } catch StickerPackError.animatedImagesNotSupported {
                    fatalError("Warning: Animated images not supported for \(characterName)")
                } catch {
                    fatalError("Warning: Unknown error creating character \(characterName): \(error.localizedDescription)")
                }
            }

            DispatchQueue.main.async {
                completionHandler(characters)
            }
        }
    }
    
    static func getEmptyCharacter(id: Int) -> Character {
        let createdCharacter: Character
        
        let characterIdentifier: String = "Cuppy" + String(id)
        let characterName: String = "Cuppy"
        let characterImage: String = "Cuppy_Main.png"
        let characterDescription: String = "Cuppy"

        do {
            createdCharacter = try Character(identifier: characterIdentifier, name: characterName, imageFileName: characterImage, description: characterDescription)
        } catch StickerPackError.fileNotFound {
            fatalError("Warning: Character image not found for \(characterName): \(characterImage)")
        } catch StickerPackError.unsupportedImageFormat(let format) {
            fatalError("Warning: Unsupported image format for \(characterName): \(format)")
        } catch StickerPackError.imageTooBig(let size, _) {
            fatalError("Warning: Image too big for \(characterName): \(size) bytes")
        } catch StickerPackError.incorrectImageSize(let size) {
            fatalError("Warning: Incorrect image size for \(characterName): \(size)")
        } catch StickerPackError.animatedImagesNotSupported {
            fatalError("Warning: Animated images not supported for \(characterName)")
        } catch {
            fatalError("Warning: Unknown error creating character \(characterName): \(error.localizedDescription)")
        }
        
        return createdCharacter;
    }
    
}
