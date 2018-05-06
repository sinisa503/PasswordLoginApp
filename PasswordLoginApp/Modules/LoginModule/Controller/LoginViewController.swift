//
//  ViewController.swift
//  PasswordLoginApp
//
//  Created by Sinisa Vukovic on 03/05/2018.
//  Copyright © 2018 Sinisa Vukovic. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
   
   @IBOutlet weak var table: UITableView!
   private var selectedUserIndex:IndexPath?
   private let USER_CELL_IDENTIFIER = "UserCell"
   private let SHOW_VALIDITION_SCREEN_SEGUEI_IDENTIFIER = "showValidationScreen"
   
   private var users:[User]? {
      didSet {
         table.reloadData()
      }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      users = ParseService.sharedInstance.getListOfUsers()
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let validationVC = segue.destination as? ValidationViewController, let users = users, let selectedUserIndex = selectedUserIndex {
         validationVC.userModel = users[selectedUserIndex.row]
         if let url = users[selectedUserIndex.row].avatarUrl {
            validationVC.userImage = NetworkService.sharedInstance.cachedImage(for: url)
         }
      }
   }
}

extension LoginViewController: UITableViewDelegate, UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if let userCell = table.dequeueReusableCell(withIdentifier: USER_CELL_IDENTIFIER) as? UserCell {
         guard let userModel = users else { return UITableViewCell() }
         userCell.configureWith(userModel: userModel[indexPath.row])
         return userCell
      }else {
         return UITableViewCell()
      }
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      selectedUserIndex = indexPath
      performSegue(withIdentifier: SHOW_VALIDITION_SCREEN_SEGUEI_IDENTIFIER, sender: self)
   }
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return users != nil ? (users?.count)! : 0
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 90.0
   }
}
