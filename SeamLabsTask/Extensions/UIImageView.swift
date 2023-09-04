//
//  UIImageView.swift
//  SeamLabsTask
//
//  Created by Hamada Ragab on 04/09/2023.
//

import Foundation
import Kingfisher
extension UIImageView {
    func setImage(from url: String,placeHolder: String? = "",completion: ((UIImage?, Error?) -> Void)? = nil) {
        guard let imageURL = URL(string: url) else { return }
        self.kf.indicatorType = .activity
        self.kf.setImage(with: imageURL,placeholder: UIImage(named: placeHolder ?? ""),options: [.transition(ImageTransition.fade(0.5))]) {result in
            switch result {
            case .success(let value):
                completion?(value.image, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
}
