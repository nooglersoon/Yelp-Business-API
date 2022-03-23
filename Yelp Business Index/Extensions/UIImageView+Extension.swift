//
//  UIImageView+Extension.swift
//  Yelp Business Index
//
//  Created by Fauzi Achmad B D on 23/03/22.
//

import Foundation
import UIKit

// Load remote image asynchronously

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
