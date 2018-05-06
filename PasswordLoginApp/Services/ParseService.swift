//
//  Utils.swift
//  PasswordLoginApp
//
//  Created by Sinisa Vukovic on 06/05/2018.
//  Copyright © 2018 Sinisa Vukovic. All rights reserved.
//

import Foundation

struct ParseService {
   
   static let sharedInstance = ParseService()
   private init() {}
   
   private let USER_LIST_FILE_NAME = "UserList"
   private let USER_LIST_FILE_TYPE = "json"
   
   func getListOfUsers() -> [User]? {
      if let path = Bundle.main.path(forResource: USER_LIST_FILE_NAME, ofType: USER_LIST_FILE_TYPE) {
         do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let usersArray = try decoder.decode(UserModel.self, from: jsonData)
            return usersArray.loginModel
         } catch let error{
            print("Error parsing users list: \(error.localizedDescription)")
            return nil
         }
      }
      return nil
   }
}
