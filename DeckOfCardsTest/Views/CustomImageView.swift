//
//  CustomImageView.swift
//  DeckOfCardsTest
//
//  Created by Alan Tseng on 9/27/18.
//  Copyright © 2018 atseng202. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {

    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        return spinner
    }()

    var lastURLUsedToLoadImage: String?

    func loadImage(urlString: String) {

        lastURLUsedToLoadImage = urlString

        self.image = nil
        spinner.startAnimating()

        if let cachedImage = ImageCache.shared.image(forKey: urlString) {
            self.image = cachedImage
            spinner.stopAnimating()
            return
        }

        guard let url = URL(string: urlString) else {
            spinner.stopAnimating()
            print("URL for string failed")
            // #imageLiteral(resourceName: "if_error_34268").scaleTo(CGSize(width: self.frame.width * 0.8, height: self.frame.height * 0.8))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in

            if let error = error {
                print("Failed to fetch post image:", error)
                DispatchQueue.main.async {
                    self?.spinner.stopAnimating()
                }
                return
            }

            if url.absoluteString != self?.lastURLUsedToLoadImage {
                print("Current url does not match the previous URL")
                DispatchQueue.main.async {
                    self?.spinner.stopAnimating()
                }
                return
            }

            guard let imageData = data else {
                DispatchQueue.main.async {
                    self?.spinner.stopAnimating()
                    print("Image data not found in data task")
                }
                return
            }

            let photoImage = UIImage(data: imageData)

            if photoImage != nil {
                ImageCache.shared.set(photoImage!, forKey: url.absoluteString)
            }

            DispatchQueue.main.async {
                self?.image = photoImage
                self?.spinner.stopAnimating()
            }
        }
        task.resume()
    }
}

