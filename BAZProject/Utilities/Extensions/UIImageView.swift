//
//  UIImage.swift
//  BAZProject
//
//  Created by 1034209 on 17/02/23.
//

import Foundation
import UIKit

extension UIImageView {
    /**
    Obtiene imagen dado una path
     - parameters:
        - path: url de la imagen tipo String
    */
    func byURL(path: String) {
        let worker = MoviesWorker(movieService: MoviesAPI())
        self.isHidden = false
        worker.getImageByMovie(path: path) { data, messageError in
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async { [weak self] in
                    self?.isHidden = true
                }
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }
    }
}
