
import Foundation
import Alamofire

class CharactersNetworkService {
    
    static let shared = CharactersNetworkService()
    
    private let url = "https://rickandmortyapi.com/api/character"
    
    func getResultsCharacter(_ delivery: @escaping ([Character]) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: CharacterResults.self) { dataResponse in
                guard let ok = dataResponse.value else { return }
                delivery(ok.results)
            }
    }
}
