//
//  CastTableViewCell.swift
//  MovieBucket
//
//  Created by Brenda Paola Lara Moreno on 02/03/23.
//

import UIKit

class CastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    private let apiManager = MovieAPIManager()
    var cast: [Cast] = []
    var imageActor: [UIImage] = []
    var idMovie: Int = 0
    weak var view: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        setUpCell()
    }
    
    func loadView() {
        apiManager.delegate = self
        apiManager.getMovieCast(idMovie: idMovie)
    }
    
    func setUpCollectionView(){
        castCollectionView.dataSource = self
        castCollectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "castCell")
    }
    
    func setUpCell() {
        let configureCell = UICollectionViewFlowLayout()
        configureCell.scrollDirection = .horizontal
        configureCell.itemSize =  CGSize(width: 110, height: 200)
        castCollectionView.setCollectionViewLayout(configureCell, animated: false)
    }
}

//MARK: - CollectionView's DataSource
extension CastTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "castCell", for: indexPath) as? CastCollectionViewCell
        else { return UICollectionViewCell() }
        apiManager.getImageMovie(profilePath: cast[indexPath.row].profile_path) { imageMovie in
            cell.setupCell(image: imageMovie ?? UIImage(), name: self.cast[indexPath.row].name ?? "", character: self.cast[indexPath.row].character ?? "")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.count
    }
}

//MARK: - MovieAPIManagerDelegate
extension CastTableViewCell: MovieAPIManagerDelegate {
    func didReceiveMovies<T: Codable>(_ movies: T) {
        self.cast = movies as! [Cast]
        DispatchQueue.main.async {
            self.castCollectionView.reloadData()
        }
    }
}
