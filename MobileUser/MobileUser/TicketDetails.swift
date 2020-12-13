//
//  TicketDetails.swift
//  MobileUser
//
//  Created by John Heberle on 4/8/20.
//  Copyright © 2020 John Heberle. All rights reserved.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct TicketDetails: View {
    
    let ticket: Ticket
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Authentication QR Code")) {
                    HStack {
                        Spacer()
                        Image(uiImage: generateQRCode(from: "owner:\(ticket.owner), id:\(ticket.id)"))
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                        Spacer()
                    }
                }
                Section(header: Text("Owner")){
                    Text("\(ticket.owner)")
                }
                Section(header: Text("Stadium Section")){
                    Text("\(ticket.stadium_section)")
                }
                Section(header: Text("Seat")){
                    Text("Section: \(ticket.section), Row: \(ticket.row), Seat: \(ticket.seat)")
                }
                Section(header: Text("Game")){
                    Text("\(ticket.game)")
                }
                Section(header: Text("Season")){
                    Text("\(ticket.season)")
                }
                Section(header: Text("Location")){
                    Text("\(ticket.location)")
                }
            }
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
}
