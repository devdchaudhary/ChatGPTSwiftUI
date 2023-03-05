//
//  ChatItemView.swift
//  ChatGPTSwiftUI
//
//  Created by devdchaudhary on 05/03/23.
//

import SwiftUI

struct ChatItemView: View {
    
    @Environment(\.colorScheme) var colorScheme
    let message: GPTModel
    
    var body: some View {
        
        VStack {
            
            if message.createdBy == "OpenAI" {
                
                HStack {
                    
                    
                    Image("openAI")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    
                    
                    Spacer().frame(width: 40)
                    
                    Text(message.content)
                        .font(.system(size: 14))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .multilineTextAlignment(.leading)
                    
                }
                .padding(.top, 5)
                
            } else if message.createdBy == "me" {
                
                HStack {
                    
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .frame(width: 20, height: 20)
                    
                    Spacer().frame(width: 40)
                    
                    Text(message.content)
                        .font(.system(size: 14))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .multilineTextAlignment(.leading)
                    
                }
                .padding(.top, 30)
            }
        }
        .padding(.horizontal, 20)
    }
}

struct ChatItemView_Previews: PreviewProvider {
    static var previews: some View {
        ChatItemView(message: GPTModel(.init()))
    }
}
