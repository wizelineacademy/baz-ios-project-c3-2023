//
//  HomeMoviesHelper.swift
//  BAZProject
//
//  Created by 1014600 on 15/02/23.
//

import UIKit

// MARK: - HomeMoviesViewProtocol
extension HomeMoviesView: HomeMoviesViewProtocol {
    
    /**
     Function that reloads the collectionHomeMovie data and assigns his delegates.
     */
    func reloadCollectionViewData() {
        DispatchQueue.main.async {
            self.collectionHomeMovie.reloadData()
        }
    }
    
    /**
     Function that reloads the CollectionView when searching for a movie.
     */
    func reloadCollectionViewSearchedData() {
        self.isSearching = true
        DispatchQueue.main.async { self.title = self.searchTerm }
        if presenter?.getSearchedMovieCount() ?? 0 > 0 {
            DispatchQueue.main.async {
                self.collectionHomeMovie.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                self.collectionHomeMovie.reloadData()
            }
        }else{
            self.isSearching = false
            DispatchQueue.main.async {
                let alert = UIAlertController(title: Constants.notFoundAlertResult, message: Constants.notFoundResult, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: Constants.done, style: .cancel, handler: { UIAlertAction in
                    self.searchBar.text = ""
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    /**
     Function that show an alert in case of an error ocurred in the api response.
     */
    func catchResponse(withMessage: String?) {
        DispatchQueue.main.async {
            self.title = "\(self.presenter?.selectedCategory?.typeName ?? MovieCategory.trending.typeName)"
            if let message = withMessage, message != "" {
                let alert = UIAlertController(title: Constants.errorAlertResult, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: Constants.done, style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}

// MARK: - Protocol definition SelectedFilterProtocol
protocol SelectedFilterProtocol {
    func addFilterToMovies(category:MovieCategory)
}

// MARK: - SelectedFilterProtocol
extension HomeMoviesView: SelectedFilterProtocol {
    // MARK: - SelectedFilterProtocol functions
    /**
     Function that set category from presenter to next call de loadingView function
     */
    func addFilterToMovies(category: MovieCategory) {
        self.title = "\(category.typeName)"
        self.view.endEditing(true)
        
        self.presenter?.selectedCategory = category
        self.presenter?.loadingView()
    }
}

// MARK: - Simple HomeMoviesView extension
extension HomeMoviesView {
    
    func createPickerView(){
        self.picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.picker.delegate = self
        self.picker.dataSource = self
        self.picker.backgroundColor = UIColor.white
        self.picker.setValue(UIColor.black, forKey: "textColor")
        self.picker.autoresizingMask = .flexibleWidth
        self.picker.contentMode = .center
    }
    
    func createToolbar(){
        self.toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        self.toolBar.items = [UIBarButtonItem.init(title: Constants.done, style: .done, target: self, action: #selector(onDoneButtonTapped))]
    }
    
    @objc func onDoneButtonTapped() {
        self.toolBar.removeFromSuperview()
        self.picker.removeFromSuperview()
    }
}
