//
//  UInt64+Ext.swift
//  PasswordLoginApp
//
//  Created by Sinisa Vukovic on 06/05/2018.
//  Copyright © 2018 Sinisa Vukovic. All rights reserved.
//

import Foundation

extension UInt64 {
   func megabytes() -> UInt64 {
      return self * 1024 * 1024
   }
}
