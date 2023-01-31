//
//  MovieImageView.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 30/01/23.
//

import UIKit

class MovieImageView: UIImageView {

    /// Fetch movie poster with completion handler
    ///
    ///  - Parameter url: The given image URL
    ///  - Returns: UIImage or Error.
    ///
    
    func fetchPhoto(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void)
    {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                completionHandler(nil, error)
            }
            if let data = data, let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                if let imageToShow = UIImage(data: data){
                    DispatchQueue.main.async {
                        completionHandler(imageToShow,nil)
                    }
                }else{
                    DispatchQueue.main.async {
                        completionHandler(UIImage(named: "poster"),nil)
                    }
                }
            }
        
        }
        task.resume()
    }


}
