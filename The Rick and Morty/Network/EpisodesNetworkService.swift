
import Foundation
import Alamofire

class EpisodesNetworkService {
    
    static let shared = EpisodesNetworkService()
    
    private let url = "https://rickandmortyapi.com/api/episode"
    
    func fetchEpisodes(_ delivery: @escaping ([Episode]) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: EpisodeResults.self) { dataResponse in
                guard let allEpisodes = dataResponse.value else { return }
                delivery(allEpisodes.results)
            }
    }
}
