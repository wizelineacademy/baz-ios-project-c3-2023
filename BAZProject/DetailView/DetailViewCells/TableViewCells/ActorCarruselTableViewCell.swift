//
//  ActorCarruselTableViewCell.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 01/03/23.
//

import UIKit

class ActorCarruselTableViewCell: UITableViewCell {

    @IBOutlet weak var castCollectionView: UICollectionView!
    var casts: [Cast] = []
    
    private let sectionInsets = UIEdgeInsets(
        top: 50.0,
        left: 20.0,
        bottom: 50.0,
        right: 20.0)

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollection()
    }

    func setUpCollection(){
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
        castCollectionView.register(ActorCollectionViewCell.nib, forCellWithReuseIdentifier: ActorCollectionViewCell.identifier)
    }
    
    
    func setInfo(for casts: [Cast]){
        self.casts = casts
        self.castCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension ActorCarruselTableViewCell: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return casts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ActorCollectionViewCell.identifier,
            for: indexPath) as? ActorCollectionViewCell else {return UICollectionViewCell()}
        let cast = casts[indexPath.row]
        cell.setup(cast: cast)
        return cell
    }
}


// MARK: - Collection View Flow Layout Delegate
extension ActorCarruselTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        let numberOfItems: CGFloat = 2.5
        let collectionViewWidth = collectionView.bounds.width
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing
        let adjustedWidth = (collectionViewWidth - (spaceBetweenCells * numberOfItems - 1) - sectionInsets.left - sectionInsets.right)/numberOfItems
        let height: CGFloat = 150
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
