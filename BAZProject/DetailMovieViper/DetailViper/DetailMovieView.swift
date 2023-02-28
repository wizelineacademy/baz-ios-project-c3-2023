//
//  DetailMovieView.swift
//  BAZProject
//
//  Created by 1050210 on 11/02/23.
//  
//

import Foundation
import UIKit

class DetailMovieView: UIViewController {

    // MARK: Properties
    var presenter: DetailMoviePresenterProtocol?

    @IBOutlet weak var detailMovieImageView: UIImageView!
    @IBOutlet weak var degradeImageView: UIImageView!
    @IBOutlet weak var detailTableViewCell: UITableView!
    @IBOutlet weak var nameMovieLabel: UILabel!
    @IBOutlet weak var genresMovieLabel: UILabel!
    
    internal let minimumInterItemSpacing: CGFloat = CGFloat(8.0)
    internal let insets: CGFloat = CGFloat(8.0)
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetailTableView()
        presenter?.viewDidLoad()
    }
    
    func setupDetailTableView(){
        detailTableViewCell.separatorColor = .label
        detailTableViewCell.dataSource = self
        detailTableViewCell.delegate = self
        detailTableViewCell.register(UINib(nibName: "DetailTableViewCell", bundle: Bundle(for: DetailMovieView.self)), forCellReuseIdentifier: "DetailTableViewCell")
        detailTableViewCell.register(UINib(nibName: "DetailsTableViewCell", bundle: Bundle(for: DetailMovieView.self)), forCellReuseIdentifier: "DetailsTableViewCell")
    }
    
    @IBAction func exitDetailPress(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension DetailMovieView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getTableCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter?.getTableCell(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
    }
}

extension DetailMovieView:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(presenter?.getTableSize() ?? 0)
    }
        
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.nameMovieLabel.isHidden = indexPath.row == 0
        self.degradeImageView.isHidden = indexPath.row == 0
        self.genresMovieLabel.isHidden = indexPath.row == 0
    }
}

extension DetailMovieView: DetailMovieViewProtocol {
  
    func setupDetailsView() {
        DispatchQueue.main.async {
            self.presenter?.getDetailImage(completion: { detailImage in
                DispatchQueue.main.async {
                    if let detailImage = detailImage{
                        self.detailMovieImageView.image = detailImage
                    } else {
                        self.detailMovieImageView.image = UIImage(named: "poster")
                    }
                    self.nameMovieLabel.text = self.presenter?.detailsMovie?.original_title ?? ""
                    let genres = self.presenter?.getGenres()
                    self.genresMovieLabel.text = genres
                    self.nameMovieLabel.isHidden = true
                    self.degradeImageView.isHidden = true
                    self.genresMovieLabel.isHidden = true
                }
                
            })
        }
    }
    
    func reloadView() {
        DispatchQueue.main.async {
            self.detailTableViewCell.reloadData()
        }
    }
}