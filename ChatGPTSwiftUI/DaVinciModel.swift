//
//  DaVinciModel.swift
//  ChatGPTSwiftUI
//
//  Created by devdchaudhary on 05/03/23.
//

import Foundation

struct DaVinciModel {
    
    let id: UUID
    let content: String
    let created: Int64
    let createdBy: String
    
    init(_ data: [String:Any]) {
     
        id = UUID()
        content = data["content"] as? String ?? ""
        created = data["created"] as? Int64 ?? 0
        createdBy = data["createdBy"] as? String ?? ""
    }
}
