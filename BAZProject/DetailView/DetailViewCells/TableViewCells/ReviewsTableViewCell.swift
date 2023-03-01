//
//  ReviewsTableViewCell.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 16/02/23.
//

import UIKit

final class ReviewsTableViewCell: UITableViewCell {
    var reviews: [Review] = []
    
    private let sectionInsets = UIEdgeInsets(
        top: 50.0,
        left: 20.0,
        bottom: 50.0,
        right: 20.0)
    
    @IBOutlet weak var reviewCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollection()
    }

    func setUpCollection(){
        reviewCollection.dataSource = self
        reviewCollection.delegate = self
        reviewCollection.register(ReviewCollectionViewCell.nib, forCellWithReuseIdentifier: ReviewCollectionViewCell.identifier)
    }
    
    
    func setInfo(for reviews: [Review]){
        self.reviews = reviews
        self.reviewCollection.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension ReviewsTableViewCell: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ReviewCollectionViewCell.identifier,
            for: indexPath) as? ReviewCollectionViewCell else {return UICollectionViewCell()}
        let review = reviews[indexPath.row]
        cell.setInfo(for: review)
        return cell
    }
}


// MARK: - Collection View Flow Layout Delegate
extension ReviewsTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        let numberOfItems: CGFloat = 1
        let collectionViewWidth = collectionView.bounds.width
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing
        let adjustedWidth = (collectionViewWidth - (spaceBetweenCells * numberOfItems - 1) - sectionInsets.left - sectionInsets.right)/numberOfItems
        let height: CGFloat = 230
        return CGSize(width: adjustedWidth, height: height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
