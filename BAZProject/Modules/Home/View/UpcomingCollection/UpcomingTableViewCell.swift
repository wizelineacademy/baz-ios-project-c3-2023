//
//  upcomingTableViewCell.swift
//  MovieBucket
//
//  Created by Brenda Paola Lara Moreno on 02/03/23.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    
    private var upcomingMovies: [Movie] = []
    private let apiManager = MovieAPIManager()
    var imagesMovies: [UIImage] = []
    weak var view: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        setUpCell()
        
        apiManager.delegate = self
        apiManager.getUpcomingMovies()
        
    }
    
    func setUpCollectionView(){
        upcomingCollectionView.dataSource = self
        upcomingCollectionView.delegate = self
        upcomingCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    
    func setUpCell() {
        let configureCell = UICollectionViewFlowLayout()
        configureCell.scrollDirection = .horizontal
        configureCell.itemSize =  CGSize(width: 110, height: 200)
        upcomingCollectionView.setCollectionViewLayout(configureCell, animated: false)
    }
}

//MARK: - CollectionView's DataSource
extension UpcomingTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell
        else { return UICollectionViewCell() }
        apiManager.getImageMovie(profilePath: upcomingMovies[indexPath.row].poster_path) { imageMovie in
            cell.setupCollectionCell(image: imageMovie ?? UIImage(), title:  self.upcomingMovies[indexPath.row].title)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingMovies.count
    }
    
}

//MARK: - CollectionView's Delegate
extension UpcomingTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destination = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {
            return
        }
        destination.movie = upcomingMovies[indexPath.row]
        view?.navigationController?.pushViewController(destination, animated: true)
    }
}

//MARK: - MovieAPIManagerDelegate
extension UpcomingTableViewCell: MovieAPIManagerDelegate {
    func didReceiveMovies<T: Codable>(_ movies: T) {
        self.upcomingMovies = movies as! [Movie]
        DispatchQueue.main.async {
            self.upcomingCollectionView.reloadData()
        }
    }    
}
