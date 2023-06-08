//
//  DataProvider.swift
//  Image Generator
//
//  Created by Дмитрий Скок on 02.06.2023.
//

import UIKit.UIImage

final class DataProvider {
    static let shared = DataProvider()

    private init() {}

    var imageCache = NSCache<NSString, UIImage>()
    
    func downloadImage(url: URL, completion: @escaping (UIImage) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            let request = URLRequest(
                url: url,
                cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad,
                timeoutInterval: 1
            )
            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
                guard let self,
                      let data,
                      let image = UIImage(data: data),
                      error == nil else {
                    return
                }
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)

                DispatchQueue.main.async {
                    completion(image)
                }
            }
            dataTask.resume()
        }
    }
}
