//
//  CVCacheImageManager.swift
//  BAZProject
//
//  Created by Cristian Eduardo Villegas Alvarez on 17/04/23.
//

import Foundation

import UIKit

class CVCacheImageManager {
    
    static let baseUrlString = "https://image.tmdb.org/t/p/w500/"
    
    static let shared = CVCacheImageManager()
    private var cache = NSCache<NSString, UIImage>()
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: NSString(string: key))
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }
    class func tryFetchImageAsync(completion: @escaping (UIImage?) -> Void, fromURL url: String) {
        guard let url = URL(string: CVCacheImageManager.baseUrlString + url)
        else {
            completion(nil)
            return
        }
        if let cachedImage = CVCacheImageManager.shared.getImage(forKey: url.absoluteString) {
            // If the image is already in the cache, return it.
            completion(cachedImage)
            return
        }
        
        // Otherwise, fetch the image asynchronously from the URL.
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            // Store the image in the cache for future use.
            CVCacheImageManager.shared.setImage(image, forKey: url.absoluteString)
            
            completion(image)
        }
        task.resume()
    }

}

