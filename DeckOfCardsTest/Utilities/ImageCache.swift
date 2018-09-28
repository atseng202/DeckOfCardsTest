//
//  ImageCache.swift
//  DeckOfCardsTest
//
//  Created by Alan Tseng on 9/27/18.
//  Copyright © 2018 atseng202. All rights reserved.
//

import UIKit

class ImageCache {

    private static let _shared = ImageCache()

    var images = [String:UIImage]()

    static var shared: ImageCache {
        return _shared
    }

    init() {
        NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: .main) { [weak self] (notification) in
            self?.images.removeAll(keepingCapacity: false)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

// MARK: - Custom Accessors
extension ImageCache {

    func set(_ image: UIImage, forKey key: String) {
        images[key] = image
    }

    func image(forKey key: String) -> UIImage? {
        return images[key]
    }
}
