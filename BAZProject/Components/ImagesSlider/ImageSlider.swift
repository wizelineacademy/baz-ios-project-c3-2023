//
//  ImageSlider.swift
//  BAZProject
//
//  Created by 1058889 on 16/02/23.
//

import UIKit

final class ImageSlider: CustomView {
    
    static let  identifier: String = .imageSliderXibIdentifier
    override var nameXIB: String {ImageSlider.identifier }
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    // MARK: - Private methods
    private var imageUrlArray: [String]?
    private var timer: Timer?
    private var counter: Int = 0
    private var positionScroll: CGFloat = 0
    private let initCurrentPage: Int = LocalizedConstants.imageSliderInitCurrentPageSlider
    private let numberSections: Int = LocalizedConstants.imageSliderNumberSections
    private let numberIncrementPage: Int = LocalizedConstants.imageSliderIncrementShowImage
    private let minimunSpacingForSection: Double = LocalizedConstants.imageSliderMinimunSpacingForSection
    private var scrolledRight: Bool = false
    
    @IBOutlet weak var slidePageControl: UIPageControl!
    @IBOutlet weak var imageCollection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUp(imageUrlArray: [String]) {
        self.imageUrlArray = imageUrlArray
        registerCell()
        imageCollection.delegate = self
        setupPageControl()
        imageCollection.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPosition = scrollView.contentOffset.x / contentView.frame.width
        slidePageControl.currentPage = Int(scrollPosition)
    }
    
    func stopTimmer() {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Private methods
    private func getImageUrl(_ index: Int) -> String? {
        return imageUrlArray?[index]
    }
    
    private func registerCell() {
        imageCollection.register(CellSlider.nib(),
                                 forCellWithReuseIdentifier: CellSlider.identifier)
    }
    
    private func setupPageControl() {
        slidePageControl.numberOfPages = imageUrlArray?.count ?? initCurrentPage
        slidePageControl.currentPage = LocalizedConstants.imageSliderInitCurrentPageSlider
        initTimer()
    }
    
    private func initTimer() {
        timer = Timer.scheduledTimer(timeInterval: LocalizedConstants.imageSliderTimeInterval, target: self, selector: #selector(slide), userInfo: nil, repeats: true)
    }

    @objc private func slide() {
        guard let imageUrlArray = imageUrlArray else { return }
        var index: IndexPath = IndexPath(item: counter, section: numberSections)
        if counter >= imageUrlArray.count {
            counter = initCurrentPage
            index = IndexPath(item: counter, section: numberSections)
        } else {
            counter += numberIncrementPage
        }
        updatePositionItemOfImageCollection(for: index)
    }
    
    private func updateItemOfImageCollectionByScroll() {
        guard let imageUrlArray = imageUrlArray else { return }
        if scrolledRight {
            counter = initCurrentPage
        } else if !scrolledRight && counter == initCurrentPage {
            counter = imageUrlArray.count - numberIncrementPage
        }
        
        updatePositionItemOfImageCollection(for: IndexPath(item: counter,
                                                           section: numberSections))
    }
    
    private func updatePositionItemOfImageCollection(for index: IndexPath) {
        guaranteeMainThread {
            self.imageCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ImageSlider: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrlArray?.count ?? numberSections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellSlider.identifier, for: indexPath) as? CellSlider, let imageUrl: String = getImageUrl(indexPath.row) {
            cell.setData(imageUrl: Endpoint.img(idImage: imageUrl, sizeImage: .w500).urlString)
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ImageSlider: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimunSpacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimunSpacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets.zero
    }
}

// MARK: - UIScrollViewDelegate
extension ImageSlider: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        positionScroll = scrollView.contentOffset.x
        stopTimmer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrolledRight = scrollView.contentOffset.x > LocalizedConstants.imageSliderScrollViewContentOffsetDefaultX
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == positionScroll {
            updateItemOfImageCollectionByScroll()
        } else {
            counter = slidePageControl.currentPage
        }
        initTimer()
    }
}
