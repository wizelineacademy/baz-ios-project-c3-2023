//
//  String+Extension.swift
//  BAZProject
//
//  Created by 1058889 on 23/01/23.
//

import Foundation

extension String {
    
    func getStrUrlTheMovieDb(withRegion: Bool = true, wihtLanguage: Bool = true) -> String {
        var stringUrl: String = .theMovieDbBasePath + self + "?api_key=" + .apiKeyTheMovieDb
        stringUrl += wihtLanguage ? "&language=\(String.languageTheMovieDb)" : ""
        stringUrl += withRegion ? "&region=\(String.regionTheMovieDb)" : ""
        return stringUrl
    }
    
    func getUrlImage(sizeImage: SizeImageType) -> String {
        return .theMovieDBBasePathImages + "/" + sizeImage.rawValue + self
    }
}
