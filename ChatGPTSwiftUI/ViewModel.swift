//
//  ViewModel.swift
//  ChatGPTSwiftUI
//
//  Created by devdchaudhary on 03/03/23.
//

import SwiftUI

extension ChatView {
    
    func fetchChat(_ model: String, _ query: String) {
        
        APIHandler.shared.fetchChatResponse(model: model, searchQuery: query) { result in
            
            switch result {
                
            case .success(let data):
                                                           
                guard let created = data["created"] as? Int64 else { return }
                                                                
                guard let data = data["choices"] as? [[String:Any]] else { return }
                
                for datum in data {
                    
                    guard let message = datum["message"] as? [String:Any] else {return}
                    
                    guard let content = message["content"] as? String else { return }
                    
                    guard let role = message["role"] as? String else { return }
                    
                    let newMessage: [String:Any] = [
                        "content" : content,
                        "role": role,
                        "created" : created,
                        "createdBy" : "OpenAI"
                    ]
                                         
                    withAnimation {
                        messages.append(GPTModel(newMessage))
                    }
                }
                                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchDavinci(_ query: String) {
        
        APIHandler.shared.fetchDavinciResponse(searchQuery: query) { result in
            
            switch result {
             
            case .success(let data):
                
                let created = data["created"]
                
                guard let choices = data["choices"] as? [[String:Any]] else {return}
                                
                for datum in choices {
                    
                    guard let text = datum["text"] as? String else {return}
                                        
                    let newModel: [String:Any] = [
                        "text": text,
                        "created": created
                    ]
                       
//                    withAnimation {
//                        messages.append(DaVinciModel(newModel))
//                    }
                }
                                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
