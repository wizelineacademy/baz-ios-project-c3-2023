//
//  LoadImages.swift
//  BAZProject
//
//  Created by avirgilio on 26/01/23.
//
import UIKit

class LoadRemotedata{
    /**
     - The `saveImages(from movies: [ResultMovie])` load from the URL `https://image.tmdb.org/t/p/w500`
     - the images from the atributte `posterPath` in the `movies` object.
     - The image is saved locally to avoid the consume of images service more than the needed times
     */
    
    func saveImages(from movies: [ResultMovie]){
        var imageResult = UIImage()
        var totalPath = ""
        movies.forEach { movie in
            totalPath = filePath()?.appendingPathComponent(movie.posterPath).absoluteString ?? ""
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)") else {
                        return
                    }
            if FileManager.default.fileExists(atPath: totalPath ){return}
            let dataTask = URLSession.shared.dataTask(with: url) {  (data, _, _) in
                if let data = data {
                    imageResult = UIImage(data: data) ?? UIImage()
                    self.saveImgToLocal(imageResult, path: movie.posterPath)
                }
            }
            dataTask.resume()
        }
    }
    private func saveImgToLocal(_ image: UIImage, path: String){
        let pathFolder = path
        let totalPath = filePath()?.appendingPathComponent(String(pathFolder.dropFirst()))
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        if !FileManager.default.fileExists(atPath: totalPath?.absoluteString ?? ""){
            if let path = totalPath {
                do {
                        try? data.write(to: path)
                    }
            }
        }
    }
    
    func loadImgsFromLocal(strPath: String) -> UIImage{
        let pathFolder = strPath
        let totalPath = filePath()?.appendingPathComponent(String(pathFolder.dropFirst()))
        var imageResult = UIImage()
        if #available(iOS 16.0, *) {
            if FileManager.default.fileExists(atPath: totalPath?.path() ?? ""){
                imageResult = UIImage(contentsOfFile: totalPath?.path() ?? "") ?? UIImage()
            }else{
                imageResult = UIImage(named: "poster") ?? UIImage()
            }
        } else {
            if FileManager.default.fileExists(atPath: totalPath?.path ?? ""){
                imageResult = UIImage(contentsOfFile: totalPath?.path ?? "") ?? UIImage()
            }else{
                imageResult = UIImage(named: "poster") ?? UIImage()
            }
        }
        return imageResult
    }
    
    private func filePath() -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        return documentURL
    }
    
    /**
     - Function `get<T: Codable>(_ endpoint: String, _ decodable: T.Type, completion: @escaping (Result<T,Error>) -> Void)` is ageneric method to get the the data from the endpoint especified and returning the data parsed to the especified `T.Type`
     -
     */
    
    func get<T: Codable>(_ endpoint: String, _ decodable: T.Type, completion: @escaping (Result<T,Error>) -> Void) {
        
        guard let url = URL(string: endpoint) else{
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
          if let error = error {
            completion(.failure(error))
            return
          }
          guard let data = data else {
            completion(.failure(DownloadError.emptyData))
            return
          }
            do {
                let objectFromData = try JSONDecoder().decode(decodable.self, from: data)
                completion(.success(objectFromData) )
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
public enum DownloadError: Error {
  case emptyData
  case invalidObject
}


