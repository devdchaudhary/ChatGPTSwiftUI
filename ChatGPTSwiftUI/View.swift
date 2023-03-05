//
//  View.swift
//  ChatGPTSwiftUI
//
//  Created by devdchaudhary on 03/03/23.
//

import SwiftUI

struct ChatView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var messages: [GPTModel] = []
    @State var selection = "gpt-3.5-turbo"
    @State var chatString = ""
    @State var isLoading = false
    
    var modelType = ["gpt-3.5-turbo", "gpt-3.5-turbo-0301"]
    
    var body: some View {
        
        ZStack {
            
            switch colorScheme {
            case .dark:
                Color.bgColor
                    .ignoresSafeArea()
            case .light:
                Color.white
                    .ignoresSafeArea()
            }
            
            VStack {
                
                Picker("", selection: $selection.onChange(menuChanged(_:))) {
                    ForEach(modelType, id: \.self) { model in
                        Text(model)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }
                .pickerStyle(.menu)
                
                List {
                    
                    ForEach(messages, id: \.id) { message in
                        
                        ChatItemView(message: message)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            .listRowBackground(colorScheme == .dark ? Color.bgColor : .white)
                        
                    }
                }
                .listStyle(.inset)
                .scrollContentBackground(.hidden)
                
                HStack {
                    
                    HStack {
                        
                        TextField("Ask Me Anything", text: $chatString)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        
                        Spacer()
                        
                        Button(action: {
                            sendMessage(chatString)
                        }) {
                            Image(systemName: "paperplane")
                                .foregroundColor(colorScheme == .dark ? .white : Color.bgColor)
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical,10)
                    .background(Color(uiColor: .systemGray5))
                    .cornerRadius(30)
                    
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 15)
                
            }
            .padding(.horizontal, 10)
            .foregroundColor(colorScheme == .dark ? .white : Color.bgColor)
        }
    }
    
    private func menuChanged(_ value: String) {
        messages = []
        fetchChat(value, "Hello")
    }
    
    private func sendMessage(_ query: String) {
        
        let sentMessage: [String:Any] = [
            "content": query,
            "created": Date.now.timeIntervalSince1970,
            "createdBy": "me"
        ]
        
        withAnimation {
            messages.append(GPTModel(sentMessage))
        }
        
        fetchChat(selection, query)
    }
}
