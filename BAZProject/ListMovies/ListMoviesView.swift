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
    var listMoviesPresenter : ListMoviesPresenter?
    var arrMovies: [AllMovieTypes] = []
    lazy var btnSearch : UIButton = {
        let searchImage = UIImage(named: "magnifyingglass")
        let searchImageView = UIImageView(image: searchImage)
        searchImageView.frame.size = CGSize(width: 100, height: 50)
        let rightBarButton = UIButton(type: .system)
        rightBarButton.setImage(searchImage, for: .normal)
        rightBarButton.setTitle("Búsqueda", for: .normal)
        rightBarButton.setTitleColor(UIColor.black, for: .normal)
        rightBarButton.frame = CGRect.init(x: 0, y: 0, width: 100, height: 50)
        rightBarButton.addTarget(self, action: #selector(didTapButtonSearch), for: .touchUpInside)
        return rightBarButton
    }()

//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        listMoviesPresenter?.onViewAppear()
        self.title = "RWMovies"
        tblMovies.delegate = self
        tblMovies.dataSource = self
        tblMovies.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btnSearch)
    }
                                                                   
 //MARK: - Functions
@objc func didTapButtonSearch(){print("Mandar a búsqueda")}

}

//MARK: - Extensions
extension ListMoviesView : ListMoviesViewProtocol{
    func update(movies: [AllMovieTypes]) {
        arrMovies = movies
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
        let cell:MovieTableViewCell = tblMovies.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        
        let movies = arrMovies[indexPath.section].pagesMovies?.results ?? []
        cell.configure(with: movies)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }    
}
