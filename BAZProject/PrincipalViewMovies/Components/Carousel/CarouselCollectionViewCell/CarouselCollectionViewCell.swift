//
//  CarouselCollectionViewCell.swift
//  BAZProject
//
//  Created by nsanchezj on 16/02/23.
//

import UIKit

protocol TapGestureImgMovieProtocol: AnyObject {
    func tapGestureImgMovie(idMovie: Int?)
}

final class CarouselCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgMovie: UIImageView!
    
    weak var delegate: TapGestureImgMovieProtocol?
    var idMovie: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureImg()
    }
    
    /**
     add gesture image collectionViewCell
     */
    func addGestureImg() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onClickedImage(_:)))
        imgMovie.isUserInteractionEnabled = true
        imgMovie.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func onClickedImage(_ senderAny: Any) {
        delegate?.tapGestureImgMovie(idMovie: idMovie)
    }
}
