//
//  User.swift
//  PasswordLoginApp
//
//  Created by Sinisa Vukovic on 03/05/2018.
//  Copyright © 2018 Sinisa Vukovic. All rights reserved.
//

import Foundation

struct UserModel: Codable {
   let loginModel:[User]
}

struct User: Codable {
   let id:String
   let name:String
   let role:String
   let avatarUrl:String?
   let passHash:String
}
