//
//  TrendingViewController+HeaderBarViewControllerDelegate.swift
//  BAZProject
//
//  Created by 1058889 on 26/01/23.
//

extension TrendingViewController: HeaderBarViewControllerDelegate {
    func resizeView(heightHeader: Double) {
        heightNavbarView.constant = heightHeader
    }
}
