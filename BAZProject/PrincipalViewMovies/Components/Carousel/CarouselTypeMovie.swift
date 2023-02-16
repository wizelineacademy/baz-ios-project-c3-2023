//
//  CarouselTypeMovie.swift
//  BAZProject
//
//  Created by nsanchezj on 16/02/23.
//

import UIKit

class CarouselTypeMovie: UIView {
    
    @IBOutlet weak var collectionCarouselMovies: UICollectionView!
    @IBOutlet weak var lblTitleMoview: UILabel!
    
    let NUMBER_ONE = 1
    let WIDTH_CELL: CGFloat = 150
    public var moviesType: [Movie] = []
    
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
}

extension CarouselTypeMovie: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return NUMBER_ONE
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionCarouselMovies.dequeueReusableCell(withReuseIdentifier: "CarouselCollectionViewCell", for: indexPath) as! CarouselCollectionViewCell
        
        let url = moviesType[indexPath.row].getUrlImg(posterPath: moviesType[indexPath.row].posterPath ?? "")
        if let urlString = url { cell.imgMovie.load(url: urlString) }
        
        cell.imgMovie.contentMode = .scaleAspectFill
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: WIDTH_CELL, height: collectionView.frame.size.height)
    }
}
