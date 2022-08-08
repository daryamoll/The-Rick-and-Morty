
import Foundation
import Alamofire

class LocationsNetworkService {
    
    static let shared = LocationsNetworkService()
    
    private let url = "https://rickandmortyapi.com/api/location"
    
    func fetchLocations(_ delivery: @escaping ([Location]) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: LocationResults.self) { dataResponse in
                guard let allLocations = dataResponse.value else { return }
                delivery(allLocations.results)
            }
    }
}
