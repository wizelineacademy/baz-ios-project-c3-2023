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
    
    var objectMovie: ResultMovie?
    let manageImages = LoadRemotedata()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgImage.image = manageImages.loadImgsFromLocal(strPath: objectMovie?.posterPath ?? "")
        registerTableViewCells()
        
    }

    func registerTableViewCells(){
        
        let detailViewCell = UINib(nibName: "DetailViewCell", bundle: nil)
        tableDetails.register(detailViewCell, forCellReuseIdentifier: "detailViewCell")
    }
}

extension DetailTrendingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.row == 2 {
            return 210.0
        }else{
            return 100.0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableDetails.dequeueReusableCell(withIdentifier: "detailViewCell",
                                                          for: indexPath) as? DetailViewCell else {
            return UITableViewCell()
        }
        if let objMov = objectMovie{
            cell.loadMovieInfo(objectMovie: objMov, index: indexPath)
        }
        
        return cell
    }
}
