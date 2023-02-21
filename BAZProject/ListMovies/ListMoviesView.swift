//
//  ListMoviesView.swift
//  BAZProject
//
//  Created by hlechuga on 15/02/23.
//

import UIKit

class ListMoviesView: UIViewController {

//MARK: - IBOutlets
    @IBOutlet weak var tblMovies: UITableView!
    
//MARK: - Properties
    var presenter: ListMoviesViewOutputProtocol?
    var arrMovies: [AllMovieTypes] = []
    lazy var btnSearch : UIBarButtonItem = {
        let searchImage = UIImage(systemName: "magnifyingglass")
        let rightBarButton = UIBarButtonItem(image: searchImage, style: .plain , target: self, action: #selector(didTapButtonSearch))
        rightBarButton.tintColor = .darkText
        return rightBarButton
    }()

//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchModel()
        self.title = "RWMovies"
        tblMovies.delegate = self
        tblMovies.dataSource = self
        tblMovies.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.rightBarButtonItem = btnSearch
    }
                                                                   
 //MARK: - Functions
@objc func didTapButtonSearch() {
    presenter?.goToSearchViewController()
}

}

//MARK: - Extensions
extension ListMoviesView: ListMoviesViewInputProtocol {
  
    func loadView(from model: [AllMovieTypes]) {
        arrMovies = model
        DispatchQueue.main.async {
            self.tblMovies.reloadData()
        }
    }
}


extension ListMoviesView : UITableViewDelegate{
    
}

extension ListMoviesView : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        arrMovies.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  arrMovies[section].typeOfMovies?.description
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:MovieTableViewCell = tblMovies.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movies = arrMovies[indexPath.section].pagesMovies?.results ?? []
        cell.delegate = self
        cell.configure(with: movies)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270.0
    }    
}

extension ListMoviesView: MovieTableViewCellDelegate {
    func onSelected(movie: Movie) {
        presenter?.goToNextViewController(with: movie)
        print("Mostrar la vista Detail con esta información \(movie)")
    }
    
    
}
