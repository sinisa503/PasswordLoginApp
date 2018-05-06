//
//  PasswordLoginAppTests.swift
//  PasswordLoginAppTests
//
//  Created by Sinisa Vukovic on 03/05/2018.
//  Copyright © 2018 Sinisa Vukovic. All rights reserved.
//

import XCTest
@testable import PasswordLoginApp

class PasswordLoginAppTests: XCTestCase {
   
   let testDisct:[String:String] = [
      "lele22":"CEBB263E7ED7AA839D9211D86CBF1518",
      "spinoff3":"ADB0EA07EF2BC06F74A94A9007DBB2B2",
      "kick_ass":"EE9D25A533650894FC46BD9D50590A80",
      "underscore":"B81453378A0C6E5389111178CF249C11",
      "need aspirin":"8C5EF44D165CE982FFB70B469D4D7E6C",
      "cloverfield":"107E8373C152BEC66ECC8D335DF7206D",
      "sadKeanu":"BC86C85487D3F5D030A8A8E9970BE1AE",
      "catnip":"5C4BF758B3E4A924C49C4CD683CC638B",
      "fluffy":"CE7BCDA695C30AA2F9E5F390C820D985",
      "password":"5F4DCC3B5AA765D61D8327DEB882CF99",
      "blueeyes":"057B3B95DF64E1680DA1259CE1FB9B45",
      "limit":"AA9F73EEA60A006820D0F8768BC8A3FC"
   ]
   
   private var testUser:User?
   private var testPassword:String?
   
    override func setUp() {
        super.setUp()
      
      testPassword = "blueeyes"
      testUser = User(id: "testId", name: "testName", role: "testRole", avatarUrl: nil, passHash: "057B3B95DF64E1680DA1259CE1FB9B45")
    }
   
   
    override func tearDown() {
      super.tearDown()
      
      testUser = nil
      testPassword = nil
    }
    
   func testPasswordValidator() {
      guard let testUser = testUser,let testPassword = testPassword else { return }
      PasswordValidator.validate(password: testPassword, for: testUser) { validateOption in
         switch validateOption {
         case .valid: break
         case .invalid:
            XCTFail("Password validation not working correctly!")
         }
      }
   }
    
    func testValidatingMD5() {
      for (index, testPassword) in testDisct.enumerated() {
         XCTAssertTrue(passwordIsValid(enteredPassword: testPassword.key, savedPassword: testPassword.value)
         ,"Password number \(index) not valid")
      }
    }
   
   private func passwordIsValid(enteredPassword:String, savedPassword:String)->Bool {
      return enteredPassword.md5().uppercased() == savedPassword.uppercased()
   }
}
