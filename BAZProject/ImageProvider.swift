//
//  ImageProvider.swift
//  BAZProject
//
//  Created by 1050210 on 27/02/23.
//

import UIKit

class ImageProvider {
    
    static let shared = ImageProvider()
    private let cache = NSCache<NSString, UIImage>()

    /// Get an image from the API movies and convert the url to an UIImage and cache that image
    ///
    /// - Parameter url: Image url
    /// - Parameter completion: Escaping closure that escapes a UIImage or a nil
    /// - Returns: Escaping closure with the uiImage type, if the parse fails, can return nil
    public func getImage(for urlIdentifierImage: String, completion: @escaping (UIImage?) -> Void) {
            let urlString = "https://image.tmdb.org/t/p/w500\(urlIdentifierImage)"
            if let image = cache.object(forKey: "image-\(urlIdentifierImage)" as NSString) {
                completion(image)
                return
            }
            DispatchQueue.global(qos: .background).async {
                if let url = URL(string: urlString),
                   let data = try? Data(contentsOf: url),
                   let image: UIImage = UIImage(data: data) {
                    self.cache.setObject(image, forKey: "image")
                     completion(image)
                } else {
                    completion(nil)
                }
            }
        }
}
