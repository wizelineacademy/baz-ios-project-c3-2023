//
//  Utils.swift
//  BAZProject
//
//  Created by 1050210 on 30/01/23.
//

import Foundation
import UIKit

class Utils{
    

    func getImage(for urlIdentifierImg: String, completion: @escaping (UIImage?) -> Void) {
        let urlString = "https://image.tmdb.org/t/p/w500\(urlIdentifierImg)"
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: urlString),
               let data = try? Data(contentsOf: url ),
               let image: UIImage = UIImage(data: data){
                 completion(image)
            }
        }
    }
}
