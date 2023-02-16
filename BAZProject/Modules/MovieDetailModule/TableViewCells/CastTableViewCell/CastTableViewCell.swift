//
//  GenericTableViewCell.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 15/02/23.
//

import UIKit

class CastTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout {
    static let reusableCell = String(describing: CastTableViewCell.self)
    var data: Codable?
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCollectionViewCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func registerCollectionViewCell() {
        let cell = UINib(nibName: "GenericCollectionViewCell", bundle: nil)
        collectionView.register(cell, forCellWithReuseIdentifier: GenericCollectionViewCell.reusableIdentifier)
    }
}

extension CastTableViewCell: UICollectionViewDelegate {
    
}

extension CastTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = data as? Credit{
            return data.cast.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenericCollectionViewCell.reusableIdentifier, for: indexPath) as? GenericCollectionViewCell, let data = data as? Credit {
            cell.imageMovie.image = UIImage(named: "poster")
            DispatchQueue.main.async {
                cell.title.text = data.cast[indexPath.row].name
                cell.secondTitle.text = data.cast[indexPath.row].character
                if let image = data.cast[indexPath.row].profilePath {
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


protocol MakeCollectionProtocol {
    func makeCollection(collectionView: UICollectionView, indexPath: IndexPath, data: Codable?) -> UICollectionViewCell
}

final class MakeView {
    func makeView(collectionPropetys: MakeCollectionProtocol, collectionView: UICollectionView, indexPath: IndexPath, data: Codable?) -> UICollectionViewCell {
        return collectionPropetys.makeCollection(collectionView: collectionView , indexPath: indexPath, data: data)
    }
}

class CastCollection: MakeCollectionProtocol {
    func makeCollection(collectionView: UICollectionView, indexPath: IndexPath, data: Codable?) ->  UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenericCollectionViewCell.reusableIdentifier, for: indexPath) as? GenericCollectionViewCell, let data = data as? Credit {
            cell.imageMovie.image = UIImage(named: "poster")
            DispatchQueue.main.async {
                cell.title.text = data.cast[indexPath.row].name
                cell.secondTitle.text = data.cast[indexPath.row].character
                if let image = data.cast[indexPath.row].profilePath {
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

class MoviesCollection: MakeCollectionProtocol {
    func makeCollection(collectionView: UICollectionView, indexPath: IndexPath, data: Codable?) ->  UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenericCollectionViewCell.reusableIdentifier, for: indexPath) as? GenericCollectionViewCell, let data = data as? Movies {
            cell.imageMovie.image = UIImage(named: "poster")
            DispatchQueue.main.async {
                cell.title.text = data.results[indexPath.row].title
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
