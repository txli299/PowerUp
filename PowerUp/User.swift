//
//  User.swift
//  PowerUp
//
//  Created by Jefferson Cuartas on 11/20/23.
//

import Foundation

struct User: Codable{
    
    var id: String
    var uid: String
    var email: String
    var credit: Double
    var orders: [String]?
 

    init(id: String, uid: String,email: String,credit: Double,  orders: [String] ) {
        self.id = id
        self.uid = id
        self.email = email
        self.credit = credit
        self.orders = orders
    }
}
