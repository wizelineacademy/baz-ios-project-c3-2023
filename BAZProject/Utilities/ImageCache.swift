//
//  ImageCache.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 24/02/23.
//

import UIKit

final class ImageCache {
    static let shared: ImageCache = ImageCache()
    
    private let cache: NSCache = NSCache<NSString, UIImage>()
    
    private init() { }
    
    /// Returns and store in cache a UIImage object from the given URL
    /// - Parameters:
    ///   - url: a URL object that returns the expected image
    ///   - completion: a closure that is called when the task is completed
    /// - Returns: on success case a UIImage object, otherwise an error
    func getImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let imageName = url.lastPathComponent as NSString
        if let image = cache.object(forKey: imageName) {
            return completion(.success(image))
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    return completion(.failure(error))
                }
                if let data = data,
                   let image = UIImage(data: data) {
                    self?.cache.setObject(image, forKey: imageName)
                    return completion(.success(image))
                }
            }
        }
        task.resume()
    }
}



