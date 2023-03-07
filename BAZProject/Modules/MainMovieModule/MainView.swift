//
//  MainView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 01/02/23.
//

import UIKit

final class MainView: UIViewController, MainViewProtocol {
    weak var presenter: MainPresenterProtocol?
    var movies: Movies?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = presenter?.getTableViewDataSource()
        self.tableView.delegate = presenter?.getTableViewDelegate()
        presenter?.viewDidLoad(tableView: tableView)
        self.title = "Principal"
    }
    
    @IBAction func goToSeachView() {
        presenter?.goToSearchMovieView()
    }
    
    func reloadData(){
        tableView.reloadData()
    }
}

