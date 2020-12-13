//
//  GetTicketsFromApi.swift
//  AuthenticatorUser
//
//  Created by John Heberle on 4/8/20.
//  Copyright © 2020 John Heberle. All rights reserved.
//

import Foundation

func getTicketsFromApi() -> [Ticket] {
    
    var returnTickets = [Ticket(id: 0, owner: "", season: "", game: "", location: "", date: "", stadium_section: "", section: 0, row: 0, seat: 0)]
    
    let strData = "{\"table\":\"tickets\",\"scope\":\"hokietokacc\",\"code\":\"hokietokacc\",\"limit\":10,\"json\":true}"
    let data = Data(strData.utf8)
    
    print("\(url)/v1/chain/get_table_rows")
    let request = NSMutableURLRequest(url: NSURL(string: "\(url)/v1/chain/get_table_rows")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "POST"
    request.httpBody = data
    
    let semaphore = DispatchSemaphore(value: 0)
    
    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        
        // Process input parameter 'error'
        guard error == nil else {
            print ("URL Session Error: \(error!)")
            semaphore.signal()
            return
        }
        
        // Process input parameter 'response'. HTTP response status codes from 200 to 299 indicate success.
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            print("The API server did not return a valid response!")
            semaphore.signal()
            return
        }
        
        // Process input parameter 'data'. Unwrap Optional 'data' if it has a value.
        guard let jsonDataFromApi = data else {
            semaphore.signal()
            return
        }
        
        // JSON data is obtained from the API
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi, options: JSONSerialization.ReadingOptions.mutableContainers)

            if let dict: NSDictionary = jsonResponse as? NSDictionary {
                if let rows: NSArray = dict["rows"] as? NSArray {
                    
                    if (rows.count != 0) {
                        for i in 0 ... rows.count-1 {
                            if (i != 0) {returnTickets.append(Ticket(id: 0, owner: "", season: "", game: "", location: "", date: "", stadium_section: "", section: 0, row: 0, seat: 0))}
                            if let ticket: NSDictionary = rows[i] as? NSDictionary {
                                
                                if let id: Int = ticket["id"] as? Int {
                                    returnTickets[i].id = id
                                }
                                if let owner: String = ticket["owner"] as? String {
                                    returnTickets[i].owner = owner
                                }
                                if let season: String = ticket["season"] as? String {
                                    returnTickets[i].season = season
                                }
                                if let game: String = ticket["game"] as? String {
                                    returnTickets[i].game = game
                                }
                                if let location: String = ticket["location"] as? String {
                                    returnTickets[i].location = location
                                }
                                if let date: String = ticket["date"] as? String {
                                    returnTickets[i].date = date
                                }
                                if let stadium_section: String = ticket["stadium_section"] as? String {
                                    returnTickets[i].stadium_section = stadium_section
                                }
                                if let section: Int = ticket["section"] as? Int {
                                    returnTickets[i].section = section
                                }
                                if let row: Int = ticket["row"] as? Int {
                                    returnTickets[i].row = row
                                }
                                if let seat: Int = ticket["seat"] as? Int {
                                    returnTickets[i].seat = seat
                                }
                                
                            }
                        }
                    }

                }
                
            }
        } catch {
            semaphore.signal()
        }
        
        semaphore.signal()
    }).resume()
    
    _ = semaphore.wait(timeout: .now() + 10)
    
    return returnTickets
}
