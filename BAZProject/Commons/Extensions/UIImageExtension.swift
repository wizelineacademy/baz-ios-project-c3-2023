//
//  UIImageExtension.swift
//  BAZProject
//
//  Created by 1029187 on 09/02/23.
//

import UIKit

extension URL {
    func toImage(completion: @escaping(UIImage?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: self), let image = UIImage(data: data) {
                 completion(image)
            } else {
                completion(UIImage(named: "poster"))
            }
        }
    }
}
