//
//  ValidationViewController.swift
//  PasswordLoginApp
//
//  Created by Sinisa Vukovic on 04/05/2018.
//  Copyright © 2018 Sinisa Vukovic. All rights reserved.
//

import UIKit
import CryptoSwift

class ValidationViewController: UIViewController {
   private let VALID_PASSWORD = "Password is valid"
   private let INVALID_PASSWORD = "Password not valid"
   
   @IBOutlet weak var userImageView: UIImageView!
   @IBOutlet weak var userNameLabel: UILabel!
   @IBOutlet weak var userRoleLabel: UILabel!
   @IBOutlet weak var validateButton: UIButton!
   @IBOutlet weak var validationTextLabel: UILabel!
   @IBOutlet weak var passwordTextField: UITextField!
   @IBAction func validationButtonPressed(_ sender: UIButton) {
      validatePassword()
   }
   
   var userImage:UIImage?
   var userModel:User?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      let touchGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewWasTouched))
      view.addGestureRecognizer(touchGestureRecognizer)
   }
   
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      validateButton.layer.cornerRadius = 10
      validateButton.layer.masksToBounds = true
      userImageView.layer.cornerRadius = 5.0
      userImageView.layer.masksToBounds = true
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      validationTextLabel.isHidden = true
      if let userModel = userModel {
         userNameLabel.text = userModel.name
         userRoleLabel.text = userModel.role
      }
      if let userImage = userImage {
         userImageView.image = userImage
      }
   }
   
   fileprivate func validatePassword() {
      guard let user = userModel, let enteredPass = passwordTextField.text, enteredPass != "" else { return }
      PasswordValidator.sharedInstance.validate(password: enteredPass, for: user) { (validateOption) in
         switch validateOption {
         case .valid:
            setPassword(valid: true)
         case .invalid:
            setPassword(valid: false)
         }
         clearPasswordTextField()
      }
   }
   
   @objc private func viewWasTouched() {
      passwordTextField.resignFirstResponder()
   }
   
   private func setPassword(valid:Bool) {
      validationTextLabel.isHidden = false
      if valid {
         validationTextLabel.textColor = UIColor.green
         validationTextLabel.text = VALID_PASSWORD
      }else {
         validationTextLabel.textColor = UIColor.red
         validationTextLabel.text = INVALID_PASSWORD
      }
   }
   
   private func clearPasswordTextField() {
      passwordTextField.text = ""
   }
}
extension ValidationViewController: UITextFieldDelegate {
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      validatePassword()
      return true
   }
}
