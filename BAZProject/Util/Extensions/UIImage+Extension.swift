//
//  UIImage+Extension.swift
//  BAZProject
//
//  Created by 1058889 on 24/01/23.
//

import UIKit

extension UIImageView {
    typealias ResponseProvider = Result<Data, Error>

    func loadImage(id stringUrl: String) {
        self.addSkeletonAnimation()
        image = UIImage()
        if let imageCache = CacheManager.shared.getImageFromCache(strUrl: stringUrl) {
            self.removeSkeletonAnimation()
            image = imageCache
            return
        }

        guard URL(string: stringUrl) != nil else {
            self.addDefaultImage()
            return
        }
        getImage(strUrl: stringUrl)
    }

    func addAnimation(_ tempImg: UIImage) {
        guaranteeMainThread {
            self.alpha = LocalizedConstants.uiImageAlpha
            self.image = tempImg
            UIView.animate(withDuration: LocalizedConstants.uiImageAnimateDuration) {
                self.alpha = LocalizedConstants.uiImageAlphaOnAnimate
            }
        }
    }

    // MARK: - Private methods
    private func getImage(strUrl: String) {
        let providerNetworking: NetworkingProviderProtocol = NetworkingProviderService(session: URLSession.shared)
        let request: URLRequest = RequestType(strUrl: strUrl, method: .GET).getRequest()
        providerNetworking.sendRequest(request) { [weak self] (result: ResponseProvider) in
            self?.handleResponse(result, strUrl: strUrl)
        }
    }

    private func addDefaultImage() {
        guaranteeMainThread {
            self.removeSkeletonAnimation()
            self.image = UIImage(named: LocalizedConstants.uiImageNameDefaultImage)
        }
    }

    private func handleResponse(_ response: ResponseProvider, strUrl: String) {
        self.removeSkeletonAnimation()
        switch response {
        case .success(let data):
            guard let tempImg = UIImage(data: data) else { return }
            self.addAnimation(tempImg)
            CacheManager.shared.saveImageInCache(id: strUrl, image: tempImg)
        case .failure:
            self.addDefaultImage()
        }
    }
}
