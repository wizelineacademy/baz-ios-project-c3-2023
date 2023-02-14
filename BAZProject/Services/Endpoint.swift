//
//  Endpoint.swift
//  BAZProject
//
//  Created by 1058889 on 14/02/23.
//

import Foundation

enum BaseUrl {
    case images(sizeImage: SizeImageType)
    case api
    case apiWithEndPoint(endPoint: String)
    
    var url: String {
        switch self {
        case .images(sizeImage: let size):
            return "\(String.theMovieDBBasePathImages)/\(size.rawValue)"
        case .api:
            return .theMovieDbBasePath
        case .apiWithEndPoint(endPoint: let url):
            return "\(String.theMovieDbBasePath)\(url)?api_key=\(String.apiKeyTheMovieDb)&language=\(String.languageTheMovieDb)&region=\(String.regionTheMovieDb)"
        }
    }
}

enum Endpoint {

    case img(idImage: String, sizeImage: SizeImageType)
    case trending(mediaType: MediaType, timeWindow: TimeWindowType)
}

extension Endpoint {
    var urlString: String {
        switch self {
        case .img(idImage: let id, sizeImage: let size):
            return "\(BaseUrl.images(sizeImage: size).url)/\(id)"
        case .trending(mediaType: let media, timeWindow: let time):
            let url: String = "\(String.apiKeyEndPointTrending)/\(media.rawValue)/\(time.rawValue)"
            return BaseUrl.apiWithEndPoint(endPoint: url).url
        }
    }
}
