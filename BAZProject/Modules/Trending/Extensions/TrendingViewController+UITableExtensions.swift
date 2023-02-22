//
//  TrendingViewController+UITableExtensions.swift
//  BAZProject
//
//  Created by 1058889 on 26/01/23.
//

import UIKit

extension TrendingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return LocalizedConstants.commonHeightHeaderTable
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = getSectionHeaderForTableView(titleString: getTableTitle(),
                                                              width: Int(tableView.bounds.width))
        return headerView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = getMovie(indexPath.row)?.id else { return }
        let detail: DetailType = DetailType(mediaType: mediaType, idMedia: id)
        presenter?.showDetail(of: detail)
    }
}

extension TrendingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getDataCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellMovie.identifier) as? CellMovie,
           let movie = getMovie(indexPath.row) {
            let idImage: String = movie.backdropPath ?? ""
            cell.backgroundColor = LocalizedConstants.commonPrimaryColor
            let checkImage = UIImage(systemName: "eye")
            let checkmark = UIImageView(image: checkImage)
            checkmark.tintColor = .white
            cell.accessoryView = checkmark
            cell.setData(title: movie.title ?? "", imageUrl: Endpoint.img(idImage: idImage, sizeImage: .w500).urlString)
            return cell
        }
        return UITableViewCell()
    }
}
