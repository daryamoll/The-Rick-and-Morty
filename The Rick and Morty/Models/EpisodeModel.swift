
import Foundation

struct EpisodeResults: Decodable {
    let results: [Episode]
}

struct Episode: Decodable {
    let name: String
    let air_date: String
    let id: Int
}
