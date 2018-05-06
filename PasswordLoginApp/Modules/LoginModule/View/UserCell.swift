//
//  UserCellTableViewCell.swift
//  PasswordLoginApp
//
//  Created by Sinisa Vukovic on 03/05/2018.
//  Copyright © 2018 Sinisa Vukovic. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
   
   @IBOutlet weak var userImageView: UIImageView!
   @IBOutlet weak var userNameLabel: UILabel!
   @IBOutlet weak var userRoleLabel: UILabel!
   @IBOutlet weak var activityindicator: UIActivityIndicatorView!
   
   private let networkService = NetworkService.sharedInstance
   
   public func configureWith(userModel:User) {
      userNameLabel.text = userModel.name
      userRoleLabel.text = userModel.role
      if let url = userModel.avatarUrl {
         // Check for cached image first
         if let image = cachedImage(for: url) {
            userImageView.image = image
            stopLoadingAnimation()
         }else {
            //If there is no cached image download it
            downloadUserImage(url: url) {[weak self] image in
               self?.userImageView.image = image
               self?.stopLoadingAnimation()
            }
         }
      }
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      
      userImageView.layer.cornerRadius = 5.0
      userImageView.layer.masksToBounds = true
   }
   
   private func cachedImage(for url:String) -> UIImage? {
      if let image = networkService.cachedImage(for: url) {
         return image
      }else {
         return nil
      }
   }
   
   private func downloadUserImage(url:String, completion:@escaping (UIImage)->()) {
      networkService.downloadImage(from: url) {[weak self] downloadOption in
         switch downloadOption {
         case .success(let image):
            completion(image)
         case .failure(let error):
            self?.stopLoadingAnimation()
            print("Photo download error: \(error.debugDescription)")
         }
      }
   }
   
   private func stopLoadingAnimation() {
      activityindicator.stopAnimating()
      activityindicator.isHidden = true
   }
}
