//
//  NetworkService.swift
//  PasswordLoginApp
//
//  Created by Sinisa Vukovic on 03/05/2018.
//  Copyright © 2018 Sinisa Vukovic. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

enum DownloadOption {
   case failure(Error?)
   case success(UIImage)
}

class NetworkService {
   
   static let sharedInstance = NetworkService()
   private init() {}
   
   func downloadImage(from url:String, completion:@escaping (DownloadOption)->()){
      Alamofire.request(url, method: .get).responseImage {[weak self] response in
         guard let image = response.result.value else {
            if let error = response.error {
               completion(.failure(error))
            }
            return }
         completion(.success(image))
         self?.cache(image: image, for: url)
      }
   }
   
   let imageCache = AutoPurgingImageCache(
      memoryCapacity: UInt64(100).megabytes(),
      preferredMemoryUsageAfterPurge: UInt64(60).megabytes()
   )
   
   func cache(image: UIImage, for url: String) {
      imageCache.add(image, withIdentifier: url)
   }
   
   func cachedImage(for url: String) -> UIImage? {
      return imageCache.image(withIdentifier: url)
   }
}
