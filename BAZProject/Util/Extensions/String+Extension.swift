//
//  String+Extension.swift
//  BAZProject
//
//  Created by 1058889 on 23/01/23.
//

import UIKit

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
    
    func getColoredString(color: UIColor) -> NSMutableAttributedString {
        let range = NSString(string: self).range(of: self)
        let mutableAttributedString = NSMutableAttributedString.init(string: self)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        mutableAttributedString.addAttribute(.font, value: LocalizedConstants.commonTitleFont, range: range)
        return mutableAttributedString
    }
}
