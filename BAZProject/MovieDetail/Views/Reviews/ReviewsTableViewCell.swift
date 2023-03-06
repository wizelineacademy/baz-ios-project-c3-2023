//
//  ReviewsTableViewCell.swift
//  BAZProject
//
//  Created by hlechuga on 23/02/23.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var reviewsCollection: UICollectionView!
    
    //MARK: - Properties
    static let identifier = "ReviewsTableViewCell"
    var model:[Review] = []
    
    //MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reviewsCollection.register(ReviewCollectionViewCell.nib(), forCellWithReuseIdentifier: ReviewCollectionViewCell.identifier)
        reviewsCollection.delegate = self
        reviewsCollection.dataSource = self
    }
    
    func configure(with model:[Review]) {
        self.model = model
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//MARK: - Extensions
extension ReviewsTableViewCell: UICollectionViewDelegate {}
extension ReviewsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ReviewCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.identifier, for: indexPath) as? ReviewCollectionViewCell else { return UICollectionViewCell() }
        let reviewMovie = model[indexPath.row]
        cell.configure(with: reviewMovie)
        return cell
    }
}

extension ReviewsTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350 , height: 150)
    }
}

