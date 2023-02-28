//  Detail+Extension.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 27/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getReviewsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellReview.identifier) as? CellReview,
           let review = getReview(indexPath.row) {
            cell.backgroundColor = LocalizedConstants.commonPrimaryColor
            let review: ReviewType = ReviewType(title: "\(String.cellReviewWriteBy) \(review.author ?? "")",
                                                urlPhoto: review.authorDetails?.avatarPath ?? "",
                                                rate: Double(review.authorDetails?.rating ?? .zero),
                                                date: review.createdAt ?? "",
                                                content: review.content ?? "")
            cell.setNumberLineInZero()
            cell.hideButtonShowMore()
            cell.setData(with: review)
            return cell
        }
        return UITableViewCell()
    }
}
