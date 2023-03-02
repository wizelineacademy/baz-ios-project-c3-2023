//
//  CarouselCollectionViewCell.swift
//  BAZProject
//
//  Created by nsanchezj on 16/02/23.
//

import UIKit

protocol TapGestureImgMovieProtocol: AnyObject {
    func tapGestureImgMovie(idMovie: Int?, typeMovieList: TypeMovieList?)
}

final class CarouselCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgMovie: UIImageView!
    
    ///Delegate for tap image and push movie detail
    weak var delegate: TapGestureImgMovieProtocol?
    var idMovie: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /**
     add gesture image collectionViewCell only for SearchMovieViewController, this Controller use protocols
     */
    func addGestureImg() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onClickedImage(_:)))
        imgMovie.isUserInteractionEnabled = true
        imgMovie.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func onClickedImage(_ senderAny: Any) {
        delegate?.tapGestureImgMovie(idMovie: idMovie, typeMovieList: nil)
    }
}
