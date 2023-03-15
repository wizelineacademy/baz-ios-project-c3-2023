//
// NowPlayingTableViewCell.swift
//  MovieBucket
//
//  Created by Brenda Paola Lara Moreno on 01/03/23.
//

import UIKit

class NowPlayingTableViewCell: UITableViewCell {
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    
    private var nowPlayingmovies: [Movie] = []
    private let apiManager = MovieAPIManager()
    var imagesMovies: [UIImage] = []
    weak var view: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        setUpCell()
        
        apiManager.delegate = self
        apiManager.getNowPlayingMovies()
    }
    
    func setUpCollectionView(){
        nowPlayingCollectionView.dataSource = self
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    
    func setUpCell() {
        let configureCell = UICollectionViewFlowLayout()
        configureCell.scrollDirection = .horizontal
        configureCell.itemSize =  CGSize(width: 110, height: 200)
        nowPlayingCollectionView.setCollectionViewLayout(configureCell, animated: false)
    }
}

//MARK: - CollectionView's DataSource
extension NowPlayingTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell
        else { return UICollectionViewCell() }
        apiManager.getImageMovie(profilePath: nowPlayingmovies[indexPath.row].poster_path) { imageMovie in
            cell.setupCollectionCell(image: imageMovie ?? UIImage(), title:  self.nowPlayingmovies[indexPath.row].title)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlayingmovies.count
    }
}

// MARK: - CollectionView's Delegate
extension NowPlayingTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destination = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {
            return
        }
        destination.movie = nowPlayingmovies[indexPath.row]
        view?.navigationController?.pushViewController(destination, animated: true)
    }
}

//MARK: - MovieAPIManagerDelegate
extension NowPlayingTableViewCell: MovieAPIManagerDelegate {
    func didReceiveMovies<T: Codable>(_ movies: T) {
        self.nowPlayingmovies = movies as! [Movie]
        DispatchQueue.main.async {
            self.nowPlayingCollectionView.reloadData()
        }
    }
}
