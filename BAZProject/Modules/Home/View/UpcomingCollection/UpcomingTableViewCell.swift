//
//  upcomingTableViewCell.swift
//  MovieBucket
//
//  Created by Brenda Paola Lara Moreno on 02/03/23.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    
    let movieApi = MovieAPI()
    var upcomingMovies: [Movie] = []
    var imagesMovies: [UIImage] = []
    weak var view: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
        setUpCell()
        
        movieApi.getUpcomingMovies { [weak self] upcomingMovies in
            self?.upcomingMovies = upcomingMovies
            DispatchQueue.main.async {
                self?.upcomingCollectionView.reloadData()
            }
        }
        
    }
    
    func configCollectionView(){
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

//MARK: CollectionView's DataSource

extension UpcomingTableViewCell: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell
        else { return UICollectionViewCell() }
        
        movieApi.getImageMovie(urlString: "https://image.tmdb.org/t/p/w500\(upcomingMovies[indexPath.row].poster_path)") { imageMovie in
            cell.setupCollectionCell(image: imageMovie ?? UIImage(), title: self.upcomingMovies[indexPath.row].title)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("cantidad de peliculas\(upcomingMovies.count)")
        return upcomingMovies.count
    }
    
}

//MARK: CollectionView's Delegate
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


