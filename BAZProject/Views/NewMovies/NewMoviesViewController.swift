//
//  NewMoviesViewController.swift
//  BAZProject
//
//  Created by Mario Arceo on 01/03/23.
//

import UIKit

class NewMoviesViewController: UIViewController {
    
    var myMovie: Movie?
    var myImage: UIImage?
    let movieApi = MovieAPI()
    var nowPlayingImages: [UIImage] = []
    var nowPlayingMovies = [Movie]()
    var upcomingImages: [UIImage] = []
    var upcomingMovies = [Movie]()

    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
        
        upcomingCollectionView.delegate = self
        upcomingCollectionView.dataSource = self
        
        getNowPlayingMovies()
        getUpcomingMovies()
       
    }
    
    func getNowPlayingMovies(){
        DispatchQueue.global().async { [weak self] in
            self?.nowPlayingMovies = self?.movieApi.getMovies(ofType: .nowPlaying) ?? []
            guard let myMovies =  self?.nowPlayingMovies else { return }
            for movie in myMovies {
                let urlString = movie.posterPath
                guard let myURL = URL(string: urlString) else { return }
                self?.nowPlayingImages.append(self?.movieApi.downloadImage(from: myURL) ?? UIImage())
                DispatchQueue.main.async {
                    self?.nowPlayingCollectionView.reloadData()

                }
            }
        }
    }
    
    func getUpcomingMovies(){
        DispatchQueue.global().async { [weak self] in
            self?.upcomingMovies = self?.movieApi.getMovies(ofType: .upcoming) ?? []
            guard let myMovies =  self?.upcomingMovies else { return }
            for movie in myMovies {
                let urlString = movie.posterPath
                guard let myURL = URL(string: urlString) else { return }
                self?.upcomingImages.append(self?.movieApi.downloadImage(from: myURL) ?? UIImage())
                
                DispatchQueue.main.async {
                    self?.upcomingCollectionView.reloadData()
                }
            }
        }
    }
}


    // MARK: - CollectionView DataSource
extension NewMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            case nowPlayingCollectionView:
                return nowPlayingImages.count
            case upcomingCollectionView:
                return upcomingImages.count
            default: return 0
        }
    }
    
        //    CellConfiguration
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
            case nowPlayingCollectionView:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCollectionViewCell().identifier, for: indexPath) as? NowPlayingCollectionViewCell {
                    cell.nowPlayingImage.image = self.nowPlayingImages[indexPath.row]
                    return cell
                }
            case upcomingCollectionView:

                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCollectionViewCell().identifier, for: indexPath) as? UpcomingCollectionViewCell {
                    cell.upcomingImage.image = self.upcomingImages[indexPath.row]
                    return cell
                }
            default: return UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
        //    SelectItem
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView{
            case nowPlayingCollectionView:
                myMovie = nowPlayingMovies[indexPath.row]
                myImage = nowPlayingImages[indexPath.row]
            case upcomingCollectionView:
                myMovie = upcomingMovies[indexPath.row]
                myImage = upcomingImages[indexPath.row]
            default: break
        }
        guard let myMovie = myMovie else{ return }
        getMovieDetails(view: self, movie: myMovie , movieImage: myImage ?? UIImage())
    }
    
}

    // MARK: - CollectionView Configuration
extension NewMoviesViewController: UICollectionViewDelegateFlowLayout {
        //    CellSize
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath ) -> CGSize {
        
        return CGSize(width: view.frame.width / 5, height: 115)
    }
}


