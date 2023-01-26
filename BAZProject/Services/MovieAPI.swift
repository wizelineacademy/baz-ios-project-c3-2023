//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {
    
    let providerNetworking: NetworkingProviderProtocol = NetworkingProviderService.shared
    
    func getTrendingMedia(mediaType: MediaType,
                          timeWindow: TimeWindowType,
                          completion: @escaping (_ success: Bool,
                                                 _ resultMovies: [MovieResult]?) -> Void) {
        
        let endPoint: String = "/trending/\(mediaType.rawValue)/\(timeWindow.rawValue)"
        let strUrl: String = endPoint.getStrUrlTheMovieDb()
        
        providerNetworking.sendRequest(
            requestType: RequestType(strUrl: strUrl, method: .GET)
        ) { success, data in
            DispatchQueue.main.async {
                if success, let data = data {
                    do {
                        let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                        
                        completion(true, response.results)
                    } catch {
                        completion(false, nil)
                    }
                } else {
                    completion(false, nil)
                }
            }
        }
    }
}
