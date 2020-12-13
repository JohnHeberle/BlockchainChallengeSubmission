//
//  ContentView.swift
//  MobileUser
//
//  Created by John Heberle on 2/15/20.
//  Copyright © 2020 John Heberle. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let chicagoMaroon = Color.init(red: 123/255, green: 50/255, blue: 73/255)
    
    var body: some View {
        ZStack {
            chicagoMaroon.opacity(1).edgesIgnoringSafeArea(.all)
            Login()
        }
    }
    
}
