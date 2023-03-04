//
//  CastTableViewCell.swift
//  BAZProject
//
//  Created by hlechuga on 22/02/23.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var collectionCastView: UICollectionView!
    
    //MARK: - Properties
    static let identifier = "CastTableViewCell"
    var models:[Cast] = []
    let sizeOfCell = CGSize(width: 200, height: 100)
    
    //MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with models:[Cast]) {
        self.models = models
        collectionCastView.reloadData()
    }
    
    override func prepareForReuse() {
        self.models = []
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionCastView.register(CastCollectionViewCell.nib(), forCellWithReuseIdentifier: CastCollectionViewCell.identifier)
        collectionCastView.delegate = self
        collectionCastView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        }
    
}

//MARK: -Extensions

extension CastTableViewCell : UICollectionViewDelegate {
    
}

extension CastTableViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath)
                as? CastCollectionViewCell else { return UICollectionViewCell() }
        let cast = models[indexPath.row]
        cell.configure(with: cast)
        return cell
    }
}

extension CastTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeOfCell
    }
}
