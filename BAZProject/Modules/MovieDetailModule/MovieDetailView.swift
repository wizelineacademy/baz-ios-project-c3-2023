//
//  MovieDetailView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import UIKit

class MovieDetailView: UIViewController {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var overviewTextView: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MovieDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad(textOverview: &overviewTextView)
        getDelegates()
    }
    
    private func getDelegates(){
        tableView.delegate = presenter?.getTableViewDelegate()
        tableView.dataSource = presenter?.getTableViewDataSource()
    }
    
    @IBAction func closeScreen() {
        dismiss(animated: true)
    }
}

extension MovieDetailView: MovieDetailViewProtocol {
    func reloadData(){
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
