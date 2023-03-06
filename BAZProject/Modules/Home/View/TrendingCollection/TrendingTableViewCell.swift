//
//  ratedTableViewCell.swift
//  MovieBucket
//
//  Created by Brenda Paola Lara Moreno on 01/03/23.
//

import UIKit

class TrendingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    
    let movieApi = MovieAPI()
    var movies: [Movie] = []
    var imagesMovies: [UIImage] = []
    weak var view: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
        setUpCell()
        
        movieApi.getMovies { [weak self] movies in
            self?.movies = movies
            DispatchQueue.main.async {
                self?.trendingCollectionView.reloadData()
            }
        }
    }
    
    func configCollectionView(){
        trendingCollectionView.dataSource = self
        trendingCollectionView.delegate = self
        trendingCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    
    func setUpCell() {
        let configureCell = UICollectionViewFlowLayout()
        configureCell.scrollDirection = .horizontal
        configureCell.itemSize =  CGSize(width: 110, height: 200)
        trendingCollectionView.setCollectionViewLayout(configureCell, animated: false)
    }
}

//MARK: CollectionView's DataSource

extension TrendingTableViewCell: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell
        else { return UICollectionViewCell() }
        
        movieApi.getImageMovie(urlString: "https://image.tmdb.org/t/p/w500\(movies[indexPath.row].poster_path)") { imageMovie in
            cell.setupCollectionCell(image: imageMovie ?? UIImage(), title: self.movies[indexPath.row].title)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
}

//MARK: CollectionView's Delegate
extension TrendingTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destination = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {
            return
        }
        destination.movie = movies[indexPath.row]
        view?.navigationController?.pushViewController(destination, animated: true)
    }
    
    
}


