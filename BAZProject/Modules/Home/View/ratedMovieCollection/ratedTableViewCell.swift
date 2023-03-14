//
//  ratedTableViewCell.swift
//  MovieBucket
//
//  Created by Brenda Paola Lara Moreno on 01/03/23.
//

import UIKit

class ratedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ratedCollectionView: UICollectionView!
    
    private var ratedMovies: [Movie] = []
    private let apiManager = MovieAPIManager()
    var imagesMovies: [UIImage] = []
    weak var view: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
        setUpCell()
        
        apiManager.delegate = self
        apiManager.getRatedMovies()
    }
    
    func configCollectionView(){
        ratedCollectionView.dataSource = self
        ratedCollectionView.delegate = self
        ratedCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    
    func setUpCell() {
        let configureCell = UICollectionViewFlowLayout()
        configureCell.scrollDirection = .horizontal
        configureCell.itemSize =  CGSize(width: 210, height: 300)
        ratedCollectionView.setCollectionViewLayout(configureCell, animated: false)
    }
}

//MARK: CollectionView's DataSource

extension ratedTableViewCell: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell
        else { return UICollectionViewCell() }
        
        apiManager.getImageMovie(profilePath: ratedMovies[indexPath.row].poster_path) { imageMovie in
            cell.setupCollectionCell(image: imageMovie ?? UIImage(), title:  self.ratedMovies[indexPath.row].title)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("cantidad de peliculas\(ratedMovies.count)")
        return ratedMovies.count
    }
    
}

//MARK: CollectionView's Delegate
extension ratedTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destination = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {
            return
        }
        destination.movie = ratedMovies[indexPath.row]
        view?.navigationController?.pushViewController(destination, animated: true)
    }
}

//MARK: - MovieAPIManagerDelegate
extension ratedTableViewCell: MovieAPIManagerDelegate {
    func didReceiveMovies<T: Codable>(_ movies: T) {
        self.ratedMovies = movies as! [Movie]
        DispatchQueue.main.async {
            self.ratedCollectionView.reloadData()
        }
    }
    
    
}
