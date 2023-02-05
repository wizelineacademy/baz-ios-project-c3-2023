//
//  MainView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 01/02/23.
//

import UIKit

class MainView: UIViewController{
    var presenter: MainPresenterProtocol?
    var movies: Movies?
    @IBOutlet var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        presenter?.viewDidLoad()
    }
}

extension MainView: MainViewProtocol{
    
    
}

extension MainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell") as? MoviesTableViewCell {
                return cell
            }
        return UITableViewCell()
    }
}

extension MainView: UITableViewDelegate {
    
    
}
