//
//  String+Extension.swift
//  BAZProject
//
//  Created by 1058889 on 23/01/23.
//

import Foundation

extension String {
    
    func getStrUrlTheMovieDb(withRegion: Bool = true, wihtLanguage: Bool = true) -> String{
        var strUrl: String = .theMovieDbBasePath + self + "?api_key=" + .apiKeyTheMovieDb
        strUrl += wihtLanguage ? "&language=\(String.languageTheMovieDb)" : ""
        strUrl += withRegion ? "&region=\(String.regionTheMovieDb)" : ""
        return strUrl
    }
    
    func getUrlImage(sizeImage: SizeImageType) -> String {
        return .theMovieDBBasePathImages + "/" + sizeImage.rawValue + self
    }
}
