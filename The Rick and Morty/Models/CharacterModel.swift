
import Foundation

struct CharacterResults: Decodable {
    let results: [Character]
}

struct Character: Decodable {
    let name: String
    let gender: String
    let species: String
    let location: characterLocation
    let image: String
}

struct characterLocation: Decodable {
    let name: String
    let url: String
}
