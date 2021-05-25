//
//  ServiceAPI.swift
//  SuitmediaTest
//
//  Created by MacBook on 24/05/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation

class ServiceAPI {
    
    var isPaginating = false
    
    public func getGuests(page: Int, per_page: Int, pagination: Bool, completion: @escaping (_ guests: [GuestViewModel]?,_ errorMessage: String ) -> Void) {
        
        if pagination {
            self.isPaginating = true
        }
        
        let urlComp = NSURLComponents(string: "https://reqres.in/api/users?page=\(page)&per_page=\(per_page)")!

        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = "GET"

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 60.0
        sessionConfig.timeoutIntervalForResource = 90.0
        let session = URLSession(configuration: sessionConfig)

        session.dataTask(with: urlRequest, completionHandler: { (data, response, error) -> Void in
            if let response = response {
                print(response)
            }
            if let error = error {
                print(error)
                completion(nil, error.localizedDescription)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: AnyObject]
                    guard let jsonData = json["data"] as? [Any] else {
                        completion(nil, "")
                        return
                    }
                    
                    print(jsonData)
                    
                    var listGuest = [GuestViewModel]()
                    
                    if jsonData.count > 0 {
                        for guest in jsonData {
                            guard let Guest = guest as? [String: Any] else { return }
                            guard let id = Guest["id"] as? Int else { return }
                            guard let email = Guest["email"] as? String else { return }
                            guard let firstName = Guest["first_name"] as? String else { return }
                            guard let lastName = Guest["last_name"] as? String else { return }
                            guard let avatar = Guest["avatar"] as? String else { return }
                            
                            let guestModel = GuestModel(id: id, email: email, first_name: firstName, last_name: lastName, avatar: avatar)
                            let guestViewModel = GuestViewModel(guest: guestModel)
                            listGuest.append(guestViewModel)
                        }
                    }
                    completion(listGuest, "")
                } catch {
                    print(error)
                    completion(nil, error.localizedDescription)
                }
            }
        }).resume()
        
    }
    
}
