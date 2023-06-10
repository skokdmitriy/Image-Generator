//
//  DataProvider.swift
//  Image Generator
//
//  Created by Дмитрий Скок on 02.06.2023.
//

import UIKit.UIImage

enum NetWorkError: Error {
    case badURL
    case requestError(Error)
}

final class DataProvider {
    static let shared = DataProvider()

    private init() {}

    var imageCache = NSCache<NSString, UIImage>()

    func downloadImage(url: String, completionHandler: @escaping (Result<UIImage, NetWorkError>) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(.failure(.badURL))
            return
        }
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completionHandler(.success(cachedImage))
        } else {
            let request = URLRequest(
                url: url,
                cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad,
                timeoutInterval: 1
            )
            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
                if let error {
                    completionHandler(.failure(.requestError(error)))
                }

                guard let self,
                      let data,
                      let image = UIImage(data: data) else {
                    return
                }
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)

                DispatchQueue.main.async {
                    completionHandler(.success(image))
                }
            }
            dataTask.resume()
        }
    }
}
