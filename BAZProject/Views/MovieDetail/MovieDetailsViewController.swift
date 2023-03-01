//
//  MovieDetailsViewController.swift
//  BAZProject
//
//  Created by Mario Arceo on 01/02/23.
//
import UIKit

class MovieDetailsViewController: UIViewController {
    
    var myMovie: Movie?
    var myImage: UIImage?
    var movies: [Movie] = []
    var casting: [Casting] = []
    var castingImages: [UIImage] = []
    let movieApi = MovieAPI()
    var images: [UIImage] = []
    let tableHeight: CGFloat = 200
    var itemsPerRow: CGFloat = 1
    var similarMovies: [Movie] = []
    var similarImages: [UIImage] = []
    var recomendedMovies: [Movie] = []
    var recomendedImages: [UIImage] = []
    
    private let sectionInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)


    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var similarsCollectionView: UICollectionView!
    @IBOutlet weak var recommendedCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let myMovie = myMovie else { return }
        self.navigationItem.title = myMovie.title
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        similarsCollectionView.delegate = self
        similarsCollectionView.dataSource = self
        recommendedCollectionView.delegate = self
        recommendedCollectionView.dataSource = self
        lblMovieTitle.text = myMovie.title
        lblDescription.text = myMovie.overview
        lblGenres.text = getGenres(genres: myMovie.genresArray).replacingOccurrences(of: "_", with: "-")
        imgMovie.image = myImage
        movieApi.movieID = myMovie.id
        getCast()
        getSimilars()
        getRecommended()
    }
    func getCast(){
        DispatchQueue.global().async { [weak self] in
            self?.casting = self?.movieApi.getCasting() ?? []
            guard let casting =  self?.casting else { return }
            for person in casting {
                let urlString = person.profile_path
                guard let myURL = URL(string: urlString) else { return }
                self?.castingImages.append(self?.movieApi.downloadImage(from: myURL) ?? UIImage())
                DispatchQueue.main.async {
                    self?.castCollectionView.reloadData()
                }
            }
        }
    }
    func getSimilars(){
        DispatchQueue.global().async { [weak self] in
            self?.similarMovies = self?.movieApi.getMovies(ofType: .similar) ?? []
            guard let myMovies =  self?.similarMovies else { return }
            for movie in myMovies {
                let urlString = movie.posterPath
                guard let myURL = URL(string: urlString) else { return }
                self?.similarImages.append(self?.movieApi.downloadImage(from: myURL) ?? UIImage())
                DispatchQueue.main.async {
                    print(self?.similarImages)
                    self?.similarsCollectionView.reloadData()
                }
            }
        }
    }
    func getRecommended(){
        DispatchQueue.global().async { [weak self] in
            self?.recomendedMovies = self?.movieApi.getMovies(ofType: .recommended) ?? []
            guard let myMovies =  self?.recomendedMovies else { return }
            for movie in myMovies {
                let urlString = movie.posterPath
                guard let myURL = URL(string: urlString) else { return }
                self?.recomendedImages.append(self?.movieApi.downloadImage(from: myURL) ?? UIImage())
                DispatchQueue.main.async {
                    self?.recommendedCollectionView.reloadData()
                }
            }
        }
    }
}

    // MARK: - CollectionView DataSource
extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
            case castCollectionView:
                return castingImages.count
            case similarsCollectionView:
                return similarImages.count
            case recommendedCollectionView:
                return recomendedImages.count
            default: return 0
        }
    }
//    CellConfiguration
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
            case castCollectionView:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell().identifier, for: indexPath) as? CastCollectionViewCell {
                    cell.imgCast.image = self.castingImages[indexPath.row]
                    cell.lblCast.text = self.casting[indexPath.row].name
                    return cell
                }
            case similarsCollectionView:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarsCollectionViewCell().identifier, for: indexPath) as? SimilarsCollectionViewCell {
                    cell.imgSimilars.image = self.similarImages[indexPath.row]
                    return cell
                }
            case recommendedCollectionView:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationsCollectionViewCell().identifier, for: indexPath) as? RecommendationsCollectionViewCell {
                    cell.imgRecommendations.image = self.recomendedImages[indexPath.row]
                    return cell
                }
                
            default: return UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
//    SelectItem
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView{
            case similarsCollectionView:
                myMovie = similarMovies[indexPath.row]
                myImage = similarImages[indexPath.row]
            case recommendedCollectionView:
                myMovie = recomendedMovies[indexPath.row]
                myImage = recomendedImages[indexPath.row]
            default: break
        }
        guard let myMovie = myMovie else{ return }
        getMovieDetails(view: self, movie: myMovie , movieImage: myImage ?? UIImage())
    }
    
}

// MARK: - CollectionView Configuration
extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
//    CellSize
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath ) -> CGSize {

        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

