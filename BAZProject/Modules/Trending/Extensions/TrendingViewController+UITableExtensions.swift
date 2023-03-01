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
        guard let id = getData(indexPath.row)?.id else { return }
        if let cell = tableView.cellForRow(at: indexPath) as? CellMovie {
            cell.addAccessoryView(accesory: .eyeFill)
        }
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
           let movie = getData(indexPath.row) {
            cell.backgroundColor = LocalizedConstants.commonPrimaryColor
            cell.addAccessoryView(accesory: .eye)
            cell.setData(title: movie.mediaTitle, imageUrl: Endpoint.img(idImage: movie.backdropPath, sizeImage: .w500).urlString)
            return cell
        }
        return UITableViewCell()
    }
}
