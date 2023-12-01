//
//  User.swift
//  PowerUp
//
//  Created by Jefferson Cuartas on 11/20/23.
//

import Foundation

struct OrderDetails: Codable {
    var id: String
    var mid: String
    var startTime: String
    var endTime: String?
    var expired: Bool
}

struct User: Codable{
    
    var id: String
    var uid: String
    var email: String
    var credit: Double
    var orders: [OrderDetails]?
 

    init(id: String, uid: String,email: String,credit: Double,  orders: [OrderDetails]? = nil ) {
        self.id = id
        self.uid = uid
        self.email = email
        self.credit = credit
        self.orders = orders
    }
}
