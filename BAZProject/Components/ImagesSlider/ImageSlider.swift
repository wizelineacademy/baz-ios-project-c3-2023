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
    private var isIncreaseScroll: Bool = true
    private let initCurrentPage: Int = LocalizedConstants.imageSliderInitCurrentPageSlider
    private let numberSections: Int = LocalizedConstants.imageSliderNumberSections
    private let numberIncrementPage: Int = LocalizedConstants.imageSliderIncrementShowImage
    private let minimunSpacingForSection: Double = LocalizedConstants.imageSliderMinimunSpacingForSection
    
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
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPosition = scrollView.contentOffset.x / contentView.frame.width
        slidePageControl.currentPage = Int(scrollPosition)
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

    func stopTimmer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func initTimer() {
        timer = Timer.scheduledTimer(timeInterval: LocalizedConstants.imageSliderTimeInterval, target: self, selector: #selector(slide), userInfo: nil, repeats: true)
    }
    
    private func incrementOrDecrementCounter() {
        if isIncreaseScroll {
           counter += numberIncrementPage
        } else {
            counter -= numberIncrementPage
            if counter < initCurrentPage {
                counter = initCurrentPage
            }
        }
    }
    
    @objc private func slide() {
        guard let imageUrlArray = imageUrlArray else { return }
        var index: IndexPath = IndexPath(item: counter, section: numberSections)
        var animated: Bool = true
        if counter >= imageUrlArray.count {
            counter = initCurrentPage
            animated = false
            index = IndexPath(item: counter, section: numberSections)
        } else {
            counter += numberIncrementPage
        }
        guaranteeMainThread {
            self.imageCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: animated)
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

extension ImageSlider: UICollectionViewDelegate { }

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
        isIncreaseScroll = !(positionScroll > scrollView.contentOffset.x)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentScrollViewX: Double = scrollView.contentOffset.x
        if (contentScrollViewX >= positionScroll) && (contentScrollViewX <= positionScroll) {
            return
        }
    
        incrementOrDecrementCounter()
        initTimer()
    }
}
