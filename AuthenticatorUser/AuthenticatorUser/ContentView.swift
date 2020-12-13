//
//  ContentView.swift
//  AuthenticatorUser
//
//  Created by John Heberle on 3/2/20.
//  Copyright © 2020 John Heberle. All rights reserved.
//

import SwiftUI
import CodeScanner
import EosioSwift
import EosioSwiftAbieosSerializationProvider
import EosioSwiftSoftkeySignatureProvider

struct ContentView: View {
    
    @State var barcodeResult: String = ""
    
    var body: some View {
        VStack {
            if barcodeResult.isEmpty {
                CodeScannerView(codeTypes: [.qr], simulatedData: "HokieTok") { result in
                    switch result {
                        case .success(let code):
                            self.barcodeResult = code
                            if (code == "") {self.barcodeResult = "owner:none, id:-1"}
                        case .failure(let error):
                            print(error.localizedDescription)
                    }
                }
            } else {
                if authorize(qrCodeValue: barcodeResult) {
                    VStack{
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .frame(width: 100, height: 100)
                        
                        Spacer()
                            .frame(height: 80)
                        
                        Button(action:{
                            self.barcodeResult = ""
                        }){
                            Text("Go Back")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .padding()
                        .foregroundColor(Color.green)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                        )
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .background(Color.green)
                } else {
                    VStack{
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: 100, height: 100)
                        
                        Spacer()
                            .frame(height: 80)
                        
                        Button(action:{
                            self.barcodeResult = ""
                        }){
                            Text("Go Back")
                                .font(.title)
                                .fontWeight(.bold)
                            
                        }
                        .padding()
                        .foregroundColor(Color.red)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                        )
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .background(Color.red)
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
    
    private func authorize(qrCodeValue: String) -> Bool {
        let tickets = getTicketsFromApi()
        var owner = qrCodeValue
        owner = String(owner.dropFirst((owner.firstIndex(of: ":")?.encodedOffset ?? 0)+1))
        owner = String(owner.dropLast((owner.count-(owner.firstIndex(of: " ")?.encodedOffset ?? 0))+1))
        
        var id = qrCodeValue
        id = String(id.dropFirst((id.lastIndex(of: ":")?.encodedOffset ?? 0)+1))
        
        if (tickets.count == 0) {return false}
        
        for i in 0...tickets.count-1 {
            if (tickets[i].owner == owner && tickets[i].id == Int(id)) { return true }
        }
        
        return false
    }
}
