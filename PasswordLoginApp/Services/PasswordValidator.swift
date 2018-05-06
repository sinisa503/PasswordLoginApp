//
//  PasswordValidator.swift
//  PasswordLoginApp
//
//  Created by Sinisa Vukovic on 03/05/2018.
//  Copyright © 2018 Sinisa Vukovic. All rights reserved.
//

import Foundation

enum ValidateOption {
   case valid
   case invalid
}

class PasswordValidator  {
   
   static let sharedInstance = PasswordValidator()
   private init() {}

   func validate(password: String, for user: User, completion:(ValidateOption)->()) {
      if passwordIsValid(enteredPassword: password, savedPassword: user.passHash) {
         completion(.valid)
      }else {
         completion(.invalid)
      }
   }
   
   private func passwordIsValid(enteredPassword:String, savedPassword:String)->Bool {
      return enteredPassword.md5().uppercased() == savedPassword.uppercased()
   }
}
