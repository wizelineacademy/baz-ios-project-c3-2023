//
//  DetailsViewController.swift
//  MovieBucket
//
//  Created by Brenda Paola Lara Moreno on 02/03/23.
//

import UIKit
class DetailsViewController: UIViewController {
    
    private let apiManager = MovieAPIManager()
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var detailTableView: UITableView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpImageMovie()
        detailTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.post(name: Notification.Name("MovieDetailShown"), object: nil)
    }
    
    func setUpImageMovie(){
        apiManager.getImageMovie(profilePath: movie?.poster_path) { imageMovie in
            self.setupImage(image: imageMovie ?? UIImage(), title: self.movie?.title ?? "")
        }
    }
    
    func setupImage(image: UIImage, title: String){
        DispatchQueue.main.async {
            self.imageMovie.image = image
        }
    }
    
    func setUpTableView(){
        detailTableView.dataSource = self
        detailTableView.register(UINib(nibName: "CastTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "castTableCell")
        detailTableView.register(UINib(nibName: "ReviewTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "reviewTableCell")
        detailTableView.register(UINib(nibName: "SimilarTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "similarTableCell")
        detailTableView.register(UINib(nibName: "RecommendationsTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "recoTableCell")
        detailTableView.register(UINib(nibName: "OverviewTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "overviewTableCell")
        
    }
}

extension DetailsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "overviewTableCell") as? OverviewTableViewCell else { return UITableViewCell() }
            cell.loadText(text: movie?.overview ?? "")
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "castTableCell") as? CastTableViewCell else { return UITableViewCell() }
            cell.view = self
            cell.idMovie = movie?.id ?? 0
            cell.loadView()
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "similarTableCell") as? SimilarTableViewCell else { return UITableViewCell() }
            cell.view = self
            cell.idMovie = movie?.id ?? 0
            cell.loadView()
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "recoTableCell") as? RecommendationsTableViewCell else { return UITableViewCell() }
            cell.view = self
            cell.idMovie = movie?.id ?? 0
            cell.loadView()
            return cell
            
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "reviewTableCell") as? ReviewTableViewCell else { return UITableViewCell() }
            cell.view = self
            cell.idMovie = movie?.id ?? 0
            cell.loadView()
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
