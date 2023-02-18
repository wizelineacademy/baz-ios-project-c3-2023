//
//  ShowMoviesTableViewCell.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 15/02/23.
//

import UIKit

final class ShowMoviesTableViewCell: UITableViewCell {
    static let reusableCell = String(describing: ShowMoviesTableViewCell.self)
    var data: Codable?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCollectionViewCell()
    }
    
    private func registerCollectionViewCell() {
        let cell = UINib(nibName: "GenericCollectionViewCell", bundle: nil)
        collectionView.register(cell, forCellWithReuseIdentifier: GenericCollectionViewCell.reusableIdentifier)
    }
    
}

extension ShowMoviesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = data as? Movies {
            return data.results.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenericCollectionViewCell.reusableIdentifier, for: indexPath) as? GenericCollectionViewCell, let data = data as? Movies {
            cell.imageMovie.image = UIImage(named: "poster")
            cell.title.text = data.results[indexPath.row].title
            DispatchQueue.main.async {
                
                if let image = data.results[indexPath.row].posterPath {
                    MovieAPI.getImage(from: image, handler: { imagen in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            cell.imageMovie.image = imagen
                        }
                    })
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }
}
