//
//  HomeMoviesPickerExtension.swift
//  BAZProject
//
//  Created by 1014600 on 15/02/23.
//

import UIKit

// MARK: - UIPickerViewDelegate
extension HomeMoviesView: UIPickerViewDelegate {
    
}

// MARK: - UIPickerViewDataSource
extension HomeMoviesView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.categoryPickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.categoryPickerData[row].typeName
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.addFilterToMovies(category: self.categoryPickerData[row])
    }
}
