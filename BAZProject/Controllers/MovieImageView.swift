//
//  MovieImageView.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 04/02/23.
//

import UIKit

class MovieImageView: UIImageView {
    
    /// Returns the UIImage of a partial url given.
    ///
    ///  - Parameter partialURL: partial of a url to download an image.
    ///  - Returns: UIImage
    ///
    
    func fetchImage(with partialURL: String) {
        MovieAPI.fetchPhoto(partialURLImage: partialURL) { image, error in
            if let image = image {
                self.image = image
            }
        }
    }
}

