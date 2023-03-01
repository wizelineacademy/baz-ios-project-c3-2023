//
//  PosterTableViewCell.swift
//  BAZProject
//
//  Created by hlechuga on 21/02/23.
//

import UIKit

class PosterTableViewCell: UITableViewCell {
    
    //MARK: - IBOulet
    @IBOutlet weak var imgPoster: UIImageView!
    
    //MARK: - Properties
    static var identifier = "PosterTableViewCell"
    
    //MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: identifier , bundle: nil)
    }
    
    func configure(with path: String) {
        if path.isEmpty {
            imgPoster.image = UIImage(named: "poster")
        } else {
            if let url = URL(string: path) {
                getData(from: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async {
                        self.imgPoster.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
