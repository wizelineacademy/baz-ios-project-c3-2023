//  Review+UITableExtension.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 24/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

extension ReviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return LocalizedConstants.commonHeightHeaderTable
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = getSectionHeaderForTableView(titleString: "Reviews",
                                                              width: Int(tableView.bounds.width))
        return headerView
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let id = getReview(indexPath.row)?.id else { return }
//        if let cell = tableView.cellForRow(at: indexPath) as? CellReview {
//            cell.addAccessoryView(accesory: .eyeFill)
//        }
//        let detail: DetailType = DetailType(mediaType: mediaType, idMedia: id)
//        presenter?.showDetail(of: detail)
//    }
}

extension ReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getDataCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellReview.identifier) as? CellReview,
           let review = getReview(indexPath.row) {
            cell.backgroundColor = LocalizedConstants.commonPrimaryColor
            cell.setData(title: review.content ?? "", urlPhoto: review.authorDetails?.avatarPath ?? "")
//            cell.label.numberOfLines = 0
//            cell.setData(title: movie.title ?? "", imageUrl: Endpoint.img(idImage: idImage, sizeImage: .w500).urlString)
            return cell
        }
        return UITableViewCell()
    }
}
