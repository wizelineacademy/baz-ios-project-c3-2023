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
    
    var objMovie: Movie!
    let manageImgs = LoadRemotedata()
    var arrKeys = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgImage.image = manageImgs.loadImgsFromLocal(strPath: objMovie.poster_path) 
        registerTableViewCells()
        arrKeys = objMovie.nsDictionary.allKeys as! [String]
        
    }

    func registerTableViewCells(){
        
        let detailViewCell = UINib(nibName: "DetailViewCell", bundle: nil)
        tableDetails.register(detailViewCell, forCellReuseIdentifier: "detailViewCell")
    }

}

extension DetailTrendingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if let str = arrKeys[indexPath.row] as? String, str == "overview"{
            return 200.0
        }else{
            return 100.0
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableDetails.dequeueReusableCell(withIdentifier: "detailViewCell",
                                                     for: indexPath) as! DetailViewCell
        
        var strKey = ""
        if let str = arrKeys[indexPath.row] as? String{
            strKey = str
        }
        cell.lblElementName.text = strKey.replacingOccurrences(of: "_", with: " ").capitalized
        
        if objMovie.dictionary[strKey] is Int {
            if let tmpInt = objMovie.dictionary[strKey] as? Int{
                cell.lblElementValue.text = String(tmpInt)
            }
        }else if objMovie.dictionary[strKey] is Double{
            if let tmpDouble = objMovie.dictionary[strKey] as? Double{
                cell.lblElementValue.text = String(tmpDouble)
            }
        }else{
            cell.lblElementValue.text = objMovie.dictionary[strKey] as? String
        }
        return cell
    }

    
    
}
