//
//  GuestModel.swift
//  SuitmediaTest
//
//  Created by MacBook on 24/05/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation

class GuestModel {
    var id: Int!
    var email: String!
    var first_name: String!
    var last_name: String!
    var avatar: String!

    required init(id: Int, email: String, first_name: String, last_name: String, avatar: String) {
        self.id = id
        self.email = email
        self.first_name = first_name
        self.last_name = last_name
        self.avatar = avatar
    }
}
