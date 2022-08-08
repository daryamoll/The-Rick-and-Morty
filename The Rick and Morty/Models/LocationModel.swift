
import Foundation

struct LocationResults: Decodable {
    let results: [Location]
}

struct Location: Codable {
    let name: String
    let type: String
    let dimension: String
}
