//
//  ImageProvider.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 28/02/23.
//

import UIKit

final class ImageProvider {
    static let shared = ImageProvider()

    // MARK: - Private methods
    private let cache = NSCache<NSString, UIImage>()
    
    /**    func to fetch image
     - Parameter from: urlImage url
     */
    public func fetchImage(from urlImage: String, completion: @escaping (UIImage?) -> Void) {
        if let image = cache.object(forKey: "image") {
            completion(image)
            return
        }
        guard let url = URL(string: URLComponentsHelper.imageUrl(imageUrl: urlImage)) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                self?.cache.setObject(image, forKey: urlImage as NSString)
                completion(image)
            }
        }
        task.resume()
    }
}
