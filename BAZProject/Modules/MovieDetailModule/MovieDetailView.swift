//
//  MovieDetailView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import UIKit

class MovieDetailView: UIViewController, MovieDetailViewProtocol {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MovieDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func closeScreen() {
        dismiss(animated: true)
    }
    
    func reloadData(){
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension MovieDetailView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = presenter?.interactor?.movieApiData.getArrayDataMovie?.count else { return 0 }
        return rows
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let title = presenter?.interactor?.movieApiData.getArrayDataMovie {
            switch section {
            case 0:
                presenter?.getMoviesData(from: title[.creditMovie(movieId: "0")])
            default: debugPrint("value not Found")
            }
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
