//
//  ImageSlider.swift
//  BAZProject
//
//  Created by 1058889 on 16/02/23.
//

import UIKit

private enum CellType {
    case cellSlider, cellMovieTop
}

protocol ImageSliderDelegate: AnyObject {
    func indexDidSelect(_ index: Int, object: ImageSlider)
}

final class ImageSlider: CustomView {

    static let  identifier: String = .imageSliderXibIdentifier
    override var nameXIB: String {ImageSlider.identifier }
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    weak var delegate: ImageSliderDelegate?

    // MARK: - Private methods
    private var imageUrlArray: [String]?
    private var cellMovieTypeArray: [CellMovieType]?
    private var cellType: CellType?
    private var timer: Timer?
    private var counter: Int = 0
    private var positionScroll: CGFloat = 0
    private let initCurrentPage: Int = LocalizedConstants.imageSliderInitCurrentPageSlider
    private let numberSections: Int = LocalizedConstants.imageSliderNumberSections
    private let numberIncrementPage: Int = LocalizedConstants.imageSliderIncrementShowImage
    private let minimunSpacingForSection: Double = LocalizedConstants.imageSliderMinimunSpacingForSection
    private var scrolledRight: Bool = false
    private var imageContentMode: ContentMode?

    @IBOutlet weak private var slidePageControl: UIPageControl!
    @IBOutlet weak private var imageCollection: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUp(imageUrlArray: [String], imageContentMode: ContentMode? = nil) {
        cellType = .cellSlider
        self.imageContentMode = imageContentMode
        guaranteeMainThread {
            self.imageUrlArray = imageUrlArray
            self.initRegister()
        }
    }

    func setUp(_ cellMovieTypeAray: [CellMovieType]) {
        cellType = .cellMovieTop
        guaranteeMainThread {
            self.cellMovieTypeArray = cellMovieTypeAray
            self.initRegister()
        }
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
    private func initRegister() {
        registerCell()
        imageCollection.delegate = self
        setupPageControl()
        imageCollection.reloadData()
    }

    private func registerCell() {
        guard let cellType = cellType else { return }
        switch cellType {
        case .cellSlider:
            registerCellSlider()
        case .cellMovieTop:
            registerCellMovieTop()
        }
    }

    private func getImageUrl(_ index: Int) -> String? {
        return imageUrlArray?[index]
    }

    private func getCellMovieTop(_ index: Int) -> CellMovieType? {
        return cellMovieTypeArray?[index]
    }

    private func registerCellSlider() {
        imageCollection.register(CellSlider.nib(),
                                 forCellWithReuseIdentifier: CellSlider.identifier)
    }

    private func registerCellMovieTop() {
        imageCollection.register(CellMovieTop.nib(),
                                 forCellWithReuseIdentifier: CellMovieTop.identifier)
    }

    private func setupPageControl() {
        slidePageControl.numberOfPages = getNumberOfItems()
        slidePageControl.currentPage = LocalizedConstants.imageSliderInitCurrentPageSlider
        initTimer()
    }

    func initTimer() {
        stopTimmer()
        timer = Timer.scheduledTimer(timeInterval: LocalizedConstants.imageSliderTimeInterval,
                                     target: self,
                                     selector: #selector(slide),
                                     userInfo: nil,
                                     repeats: true)
    }

    @objc private func slide() {
        let totalItems: Int = getNumberOfItems()
        if totalItems == numberSections { return }
        var index: IndexPath = IndexPath(item: counter, section: numberSections)
        if counter >= totalItems {
            counter = initCurrentPage
            index = IndexPath(item: counter, section: numberSections)
        } else {
            counter += numberIncrementPage
        }
        updatePositionItemOfImageCollection(for: index)
    }

    private func updateItemOfImageCollectionByScroll() {
        let totalItems: Int = getNumberOfItems()
        if totalItems == numberSections { return }
        if scrolledRight {
            counter = initCurrentPage
        } else if !scrolledRight && counter == initCurrentPage {
            counter = totalItems - numberIncrementPage
        }

        updatePositionItemOfImageCollection(for: IndexPath(item: counter,
                                                           section: numberSections))
    }

    private func updatePositionItemOfImageCollection(for index: IndexPath) {
        guaranteeMainThread {
            self.imageCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }
    }

    private func getNumberOfItems() -> Int {
        guard let cellType = cellType else { return numberSections }
        switch cellType {
        case .cellSlider:
            return imageUrlArray?.count ?? numberSections
        case .cellMovieTop:
            return cellMovieTypeArray?.count ?? numberSections
        }
    }

    private func getUICollectionViewCell(of indexPath: IndexPath,
                                         in collectionView: UICollectionView
    ) -> UICollectionViewCell {
        guard let cellType = cellType else { return UICollectionViewCell() }
        switch cellType {
        case .cellSlider:
            return getCellSlider(of: indexPath, in: collectionView)
        case .cellMovieTop:
            return getCellMovieTop(of: indexPath, in: collectionView)
        }
    }

    private func getCellSlider(of indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellSlider.identifier,
                                                         for: indexPath) as? CellSlider,
            let imageUrl: String = getImageUrl(indexPath.row) {
            cell.setData(imageUrl: Endpoint.img(idImage: imageUrl, sizeImage: .w500).urlString, imageContentMode: imageContentMode)
            return cell
        }
        return UICollectionViewCell()
    }

    private func getCellMovieTop(of indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellMovieTop.identifier,
                                                         for: indexPath) as? CellMovieTop,
            let cellMovieType: CellMovieType = getCellMovieTop(indexPath.row) {
            cell.setData(cellMovieType: cellMovieType)
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDataSource
extension ImageSlider: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getNumberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        return getUICollectionViewCell(of: indexPath, in: collectionView)
    }
}

// MARK: - UICollectionViewDelegate
extension ImageSlider: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.indexDidSelect(indexPath.row, object: self)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ImageSlider: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return minimunSpacingForSection
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return minimunSpacingForSection
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
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
        scrolledRight = scrollView.contentOffset.x > LocalizedConstants.imageSliderValueDefaultX
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
