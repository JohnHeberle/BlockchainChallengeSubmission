//
//  Login.swift
//  MobileUser
//
//  Created by John Heberle on 3/1/20.
//  Copyright © 2020 John Heberle. All rights reserved.
//

import SwiftUI
import EosioSwift
import EosioSwiftAbieosSerializationProvider
import EosioSwiftSoftkeySignatureProvider

struct Login: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var authentication = false
    @State private var showLoginAlert = false
    
    var body: some View {
        
        VStack {
            if !authentication {
                Spacer()
                    .frame(height: 100)
                Image("virginia_tech_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width-40, alignment: .center)
                Spacer()
                    .frame(height: 30)
                HStack {
                    Spacer()
                        .frame(width: 10)
                    HStack {
                        Spacer()
                            .frame(width: 20)
                        Image(systemName: "person.fill")
                        TextField("Username", text: $username)
                            .padding(.leading, 12)
                            .font(.system(size: 20))
                    }
                    .frame(height: 30)
                    .background(Color.white)
                    .cornerRadius(10)
                    Spacer()
                        .frame(width: 10)
                }
                
                HStack {
                    Spacer()
                        .frame(width: 10)
                    HStack {
                        Spacer()
                            .frame(width: 20)
                        Image(systemName: "lock.fill")
                        SecureField("Password", text: $password)
                            .padding(.leading, 12)
                            .font(.system(size: 20))
                    }
                    .frame(height: 30)
                    .background(Color.white)
                    .cornerRadius(10)
                    Spacer()
                        .frame(width: 10)
                }
                Spacer()
                    .frame(height: 20)
                Button(action:{
                    self.authenticate()
                    uName = self.username
                }){
                    Text("Login")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                .frame(width: 100, height: 50, alignment: .center)
                .foregroundColor(Color.white)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.init(red: 232/255, green: 119/255, blue: 34/255))
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                )
                Spacer()
            } else {
                
                SplashPage(tickets: getTicketsFromApi())
                
            }
            
        } // End VStack
        .alert(isPresented: $showLoginAlert, content: { self.loginAlert })
    }
    
    private func authenticate() {
        let tickets = getTicketsFromApi()
        
        for i in 0...tickets.count-1 {
            if (tickets[i].owner == self.username) { authentication = true }
        }
        
        if (!authentication) { self.showLoginAlert = true }
    }
    
    var loginAlert: Alert {
        Alert(title: Text("Invalid Login"),
              message: Text("The user is not valid or the password is incorrect"),
              dismissButton: .default(Text("OK")) )
    }
    
}

/*
 
 let rpcProvider = EosioRpcProvider(endpoint: URL(string: "https://8888-fab8574e-cec0-4c8e-9acc-eb728ea78411.ws-us02.gitpod.io")!)
 let tableRequest = EosioRpcTableRowsRequest(scope: "hokietokacc", code: "hokietokacc", table: "tickets")
 rpcProvider.getTableRows(requestParameters: tableRequest) { result in
 switch result {
 case .success(let balance):
 print(balance)
 case .failure(let error):
 print(error.originalError)
 }
 }
 */
