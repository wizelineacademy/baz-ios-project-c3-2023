//
//  MainView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 01/02/23.
//

import UIKit

class MainView: UIViewController, MainViewProtocol {
    var presenter: MainPresenterProtocol?
    var movies: Movies?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = presenter?.getTableViewDataSource()
        self.tableView.delegate = presenter?.getTableViewDelegate()
        presenter?.viewDidLoad()
    }
    
    @IBAction func goToSeachView() {
        presenter?.goToSearchMovieView()
    }
    
    @IBAction func didChangeSegmentControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            presenter?.getMoviesData(from: .trending)
        case 1:
            presenter?.getMoviesData(from: .nowPlaying)
        case 2:
            presenter?.getMoviesData(from: .popular)
        case 3:
            presenter?.getMoviesData(from: .topRated)
        case 4:
            presenter?.getMoviesData(from: .upcoming)
        default:
            debugPrint("No segmented found")
        }
    }
    
    func reloadData(){
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

