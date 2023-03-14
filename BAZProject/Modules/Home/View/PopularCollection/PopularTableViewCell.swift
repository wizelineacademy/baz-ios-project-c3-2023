//
//  popularTableViewCell.swift
//  MovieBucket
//
//  Created by Brenda Paola Lara Moreno on 02/03/23.
//

import UIKit

class PopularTableViewCell: UITableViewCell {
    
    @IBOutlet weak var popularCollectionView: UICollectionView!
    private var popularMovies: [Movie] = []
    private let apiManager = MovieAPIManager()
    var imagesMovies: [UIImage] = []
    weak var view: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        setUpCell()
        
        apiManager.delegate = self
        apiManager.getPopularMovies()
        
    }
    
    func setUpCollectionView(){
        popularCollectionView.dataSource = self
        popularCollectionView.delegate = self
        popularCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    
    func setUpCell() {
        let configureCell = UICollectionViewFlowLayout()
        configureCell.scrollDirection = .horizontal
        configureCell.itemSize =  CGSize(width: 110, height: 200)
        popularCollectionView.setCollectionViewLayout(configureCell, animated: false)
    }
}

//MARK: - CollectionView's DataSource
extension PopularTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell
        else { return UICollectionViewCell() }
        apiManager.getImageMovie(profilePath: popularMovies[indexPath.row].poster_path) { imageMovie in
            cell.setupCollectionCell(image: imageMovie ?? UIImage(), title:  self.popularMovies[indexPath.row].title)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMovies.count
    }
}

//MARK: - CollectionView's Delegate
extension PopularTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destination = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {
            return
        }
        destination.movie = popularMovies[indexPath.row]
        view?.navigationController?.pushViewController(destination, animated: true)
    }
}

//MARK: - MovieAPIManagerDelegate
extension PopularTableViewCell: MovieAPIManagerDelegate {
    func didReceiveMovies<T: Codable>(_ movies: T) {
        self.popularMovies = movies as! [Movie]
        DispatchQueue.main.async {
            self.popularCollectionView.reloadData()
        }
    }
}
