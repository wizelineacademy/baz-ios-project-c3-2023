//
//  CellSlider.swift
//  BAZProject
//
//  Created by 1058889 on 16/02/23.
//

import UIKit

/// This class allows you to create a cell with only images.
///
/// :conditions: The methods it has are those declared in the class 'CellSlider':
/// * func setData
///
final class CellSlider: UICollectionViewCell {
    static let  identifier: String = .cellSliderXibIdentifier

    /// This function allows to get the UINib of the cell.
    /// Way to call CellSlider.nib()
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    // MARK: - Declaration IBOutlets
    @IBOutlet weak private var photoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    /// This function allows you to configure the cell, where you must indicate the imageUrl parameter and optionally imageContentMode.
    ///
    /// :param: imageUrl String indicating the url string of image
    ///         numberStars Int indicating the ContentMode of image (optional parameter)
    func setData(imageUrl: String, imageContentMode: ContentMode? = nil) {
        setContentMode(to: imageContentMode)
        photoImageView.loadImage(id: imageUrl)
    }

    // MARK: - Private method
    private func setContentMode(to imageContentMode: ContentMode?) {
        if let imageContentMode = imageContentMode {
            photoImageView.contentMode = imageContentMode
        }
    }
}
