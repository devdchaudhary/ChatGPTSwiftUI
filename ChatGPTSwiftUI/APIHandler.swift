//
//  APIHandler.swift
//  ChatGPTSwiftUI
//
//  Created by devdchaudhary on 03/03/23.
//

import Foundation
import SwiftKeychainWrapper

struct APIHandler {
    
    enum URLExtension: String {
        
        // MODEL
        case model = "/model"
        
        case chat = "/chat/completions"
        
        case completions = "/completions"
    }
    
    let baseUrl = "https://api.openai.com/v1"
    
    static let shared = APIHandler()
    
    func fetchChatResponse(model: String, searchQuery: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        
        KeychainWrapper.standard.set("", forKey: "baseApiKey")
        
        let urlExt = URLExtension.chat.rawValue
        
        guard let url = URL(string: "\(baseUrl)" + "\(urlExt)") else {
            return
        }
                
        let params: [String:Any] = [
            "model": model,
            "messages": [[
                "role": "user",
                "content": searchQuery]]
        ]
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let accessKey = Constants.baseApiKey {
            request.setValue("Bearer \(accessKey)", forHTTPHeaderField: "Authorization")
        }
        
        guard let requestBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return
        }
        
        request.httpBody = requestBody
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            do {
                
                guard let data = data else { return }
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else { return }
                                
                completion(.success(json))
                
            } catch {
                print(error)
            }
        })
        task.resume()
        
    }
    
    func fetchDavinciResponse(searchQuery: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        
        KeychainWrapper.standard.set("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", forKey: "baseApiKey")
        
        let urlExt = URLExtension.completions.rawValue
        
        guard let url = URL(string: "\(baseUrl)" + "\(urlExt)") else {
            return
        }
        
        let params: [String:Any] = [
            "model": "text-davinci-003",
            "prompt": searchQuery
        ]
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(Constants.baseApiKey ?? "")", forHTTPHeaderField: "Authorization")
        
        guard let requestBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return
        }
        
        request.httpBody = requestBody
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            do {
                
                guard let data = data else { return }
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else { return }
                                
                completion(.success(json))
                
            } catch {
                print(error)
            }
        })
        task.resume()
        
    }
    
}
