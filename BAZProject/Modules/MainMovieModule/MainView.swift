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
        MovieAPI().getMovies(url: .recommendations(movieId: "603"), handler: { [weak self] data in
            do{
                self?.movies =  DecodeUtility.decode(Movies.self, from: data)
            }
        })
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.registerTableViewCells()
    }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "MoviesTableViewCell",
                                  bundle: nil)
        self.tableView.register(textFieldCell,
                                forCellReuseIdentifier: "MoviesTableViewCell")
    }
    
    @IBAction func openView(){
        presenter?.goTo()
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
