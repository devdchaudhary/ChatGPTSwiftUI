//
//  Constants.swift
//  ChatGPTSwiftUI
//
//  Created by devdchaudhary on 03/03/23.
//

import Foundation
import SwiftKeychainWrapper

struct Constants {
    
    static let baseApiKey = KeychainWrapper.standard.string(forKey: "baseApiKey")
    
}
