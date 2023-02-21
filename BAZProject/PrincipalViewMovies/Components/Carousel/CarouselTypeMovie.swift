//
//  CarouselTypeMovie.swift
//  BAZProject
//
//  Created by nsanchezj on 16/02/23.
//

import UIKit

/**
 Collection view section for show carousel movies
 show info category like popular, now, recommended...
 */

final class CarouselTypeMovie: UIView {
    
    @IBOutlet weak var collectionCarouselMovies: UICollectionView!
    @IBOutlet weak var lblTitleMoview: UILabel!
    
    var moviesType: [Movie] = []
    weak var delegate: TapGestureImgMovieProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUIForView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUIForView()
    }
    
    private func setUIForView() {
        let bundleCustomCarouselView = Bundle(for: CarouselTypeMovie.self)
        let view = UINib(nibName: "CarouselTypeMovie",
                         bundle: bundleCustomCarouselView).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = self.bounds
        view.backgroundColor = UtilsMoviesApp.shared.colorBackgroundApp
        collectionCarouselMovies.backgroundColor = UtilsMoviesApp.shared.colorBackgroundApp
        registerCollectionViewCell()
        loadLayoutForCV()
        addSubview(view)
    }
    
    private func loadLayoutForCV() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionCarouselMovies.collectionViewLayout = layout
        collectionCarouselMovies.showsHorizontalScrollIndicator = false
        collectionCarouselMovies.showsVerticalScrollIndicator = false
    }
    
    private func registerCollectionViewCell() {
        let bundle = Bundle(for: CarouselCollectionViewCell.self)
        collectionCarouselMovies.delegate = self
        collectionCarouselMovies.dataSource = self
        collectionCarouselMovies.register(UINib(nibName: "CarouselCollectionViewCell", bundle: bundle), forCellWithReuseIdentifier: "CarouselCollectionViewCell")
    }
    
    private func getNumberItemsCarousel() -> Int {
        moviesType.count > 5 ? 5 : moviesType.count
    }
}

extension CarouselTypeMovie: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return UtilsMoviesApp.shared.NUMBER_ONE
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getNumberItemsCarousel()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionCarouselMovies.dequeueReusableCell(withReuseIdentifier: "CarouselCollectionViewCell", for: indexPath) as! CarouselCollectionViewCell
        
        let url = moviesType[indexPath.row].getUrlImg(posterPath: moviesType[indexPath.row].posterPath ?? "")
        if let urlString = url { cell.imgMovie.load(url: urlString) }
        
        cell.imgMovie.contentMode = .scaleAspectFill
        cell.delegate = self
        cell.idMovie = moviesType[indexPath.row].id ?? 0
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: UtilsMoviesApp.shared.WIDTH_CELL, height: collectionView.frame.size.height)
    }
}

extension CarouselTypeMovie: TapGestureImgMovieProtocol {
    func tapGestureImgMovie(idMovie: Int?) {
        delegate?.tapGestureImgMovie(idMovie: idMovie)
    }
}
