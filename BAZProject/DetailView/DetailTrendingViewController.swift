//
//  DetailTrendingViewController.swift
//  BAZProject
//
//  Created by avirgilio on 26/01/23.
//

import UIKit

class DetailTrendingViewController: UIViewController {
    
    @IBOutlet weak var imgImage: UIImageView!
    
    @IBOutlet weak var tableDetails: UITableView!
    
    var objectMovie: ResultMovie!
    let manageImages = LoadRemotedata()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgImage.image = manageImages.loadImgsFromLocal(strPath: objectMovie.posterPath)
        registerTableViewCells()
        
    }

    func registerTableViewCells(){
        
        let detailViewCell = UINib(nibName: "DetailViewCell", bundle: nil)
        tableDetails.register(detailViewCell, forCellReuseIdentifier: "detailViewCell")
    }
}

extension DetailTrendingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.row == 3 {
            return 210.0
        }else{
            return 100.0
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableDetails.dequeueReusableCell(withIdentifier: "detailViewCell",
                                                     for: indexPath) as! DetailViewCell
        
        switch indexPath.row {
        case 0:
            cell.lblElementName.text = "Título"
            cell.lblElementValue.text = objectMovie.originalTitle
        case 1:
            cell.lblElementName.text = "Fecha Estreno"
            cell.lblElementValue.text = objectMovie.releaseDate
        case 2:
            cell.lblElementName.text = "Idioma"
            cell.lblElementValue.text = objectMovie.originalLanguage
        case 3:
            cell.lblElementName.text = "Sinopsis"
            cell.lblElementValue.text = objectMovie.overview
        default:
            cell.lblElementName.text = "N/A"
            cell.lblElementValue.text = "N/A"
        }
        return cell
    }
}
