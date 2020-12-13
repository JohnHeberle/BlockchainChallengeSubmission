//
//  SplashPage.swift
//  MobileUser
//
//  Created by John Heberle on 3/1/20.
//  Copyright © 2020 John Heberle. All rights reserved.
//

import SwiftUI

struct SplashPage: View {
    
    let tickets: [Ticket]
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                HStack {
                    Spacer()
                        .frame(width: 20)
                    VStack(alignment: .leading) {
                        Text("Hokie: ")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                        Text("\(uName)")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                HStack {
                    Spacer()
                    Image("hokie_bird")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 130)
                    Spacer()
                        .frame(width: 20)
                }
            }
            
            NavigationView {
                List {
                    if (tickets[0].owner != "") {
                        ForEach(0 ..< tickets.count) { i in
                            NavigationLink(destination: TicketDetails(ticket: self.tickets[i])) {
                                Text("\(self.tickets[i].game)")
                            }
                        }
                    }
                }
                .navigationBarTitle("Tickets", displayMode: .inline)
            }
            .frame(width: UIScreen.main.bounds.width, height: 600)
        }
    }
    
}
