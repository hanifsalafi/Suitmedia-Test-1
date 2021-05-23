//
//  GuestViewModel.swift
//  SuitmediaTest
//
//  Created by MacBook on 24/05/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation

class GuestViewModel {
    let model: GuestModel
    
    required init(guest: GuestModel) {
        self.model = guest
    }
    
    func getId() -> Int {
        return model.id
    }
    func getFullName() -> String {
        return model.first_name+" "+model.last_name
    }
    func getFirstName() -> String {
        return model.first_name
    }
    func getLastName() -> String {
        return model.last_name
    }
    func getEmail() -> String {
        return model.email
    }
    func getAvatar() -> String {
        return model.avatar
    }
}
