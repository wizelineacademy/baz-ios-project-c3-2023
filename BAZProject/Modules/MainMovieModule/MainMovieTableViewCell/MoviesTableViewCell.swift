//
//  MoviesTableViewCell.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet var movieCategoryLbl: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCollectionViewCell()
    }

    private func registerCollectionViewCell(){
        let textFieldCell = UINib(nibName: "MovieCollectionViewCell",
                                  bundle: nil)
        self.collectionView.register(textFieldCell,
                                     forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension MoviesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell{
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MoviesTableViewCell: UICollectionViewDelegate {
    
}
