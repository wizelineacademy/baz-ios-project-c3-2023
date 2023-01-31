//
//  LoadImages.swift
//  BAZProject
//
//  Created by avirgilio on 26/01/23.
//
import UIKit

class LoadRemotedata{
    /**
     - `Int`
     -
     */
    
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    
    func saveImages(from movies: [Movie]){
        var imageResult = UIImage()
        var totalPath = ""
        movies.forEach { movie in
            totalPath = filePath()?.appendingPathComponent(movie.poster_path).absoluteString ?? ""
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)") else {
                        return
                    }
            if FileManager.default.fileExists(atPath: totalPath ){return}
            let dataTask = URLSession.shared.dataTask(with: url) {  (data, _, _) in
                if let data = data {
                    imageResult = UIImage(data: data) ?? UIImage()
                    self.saveImgToLocal(imageResult, path: movie.poster_path)
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
    
//    func loadMoviesData() -> [NSDictionary] {
//
//            guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)"),
//                  let data = try? Data(contentsOf: url),
//                  let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
//                  let results = json.object(forKey: "results") as? [NSDictionary]
//            else {
//                return []
//            }
//        
////        var results: [NSDictionary] = []
////
////        guard let url = URL(string:  "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)") else {
////                    return []
////                }
////        let dataTask = URLSession.shared.dataTask(with: url) {  (data, _, _) in
////            if let data = data {
//////                DispatchQueue.main.async {
////                    let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary
////                    results = json?.object(forKey: "results") as? [NSDictionary] ?? []
//////                }
////            }
////        }
////        dataTask.resume()
//
//        return results
//    }
//    func get<T: Codable>(_ endpoint: Endpoint, callback: @escaping (Result<T,Error>) -> Void){
//        
//    }
    
    public func loadMoviesData(completion: @escaping (Result<[NSDictionary], Error>) -> Void) {
        guard let url = URL(string:  "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)") else {
            return Void()
            }
      let task = URLSession.shared.dataTask(with: url) { data, response, error in
          
        if let error = error {
          completion(.failure(error))
          return
        }

        guard let data = data else {
          completion(.failure(DownloadError.emptyData))
          return
        }

        guard let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary else {
          completion(.failure(DownloadError.invalidObject))
          return
        }
          

          completion(.success(json.object(forKey: "results") as? [NSDictionary] ?? []))
      }

      task.resume()
    }
    
}
public enum DownloadError: Error {
  case emptyData
  case invalidObject
}


