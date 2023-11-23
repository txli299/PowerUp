//
//  OrderDto.swift
//  PowerUp
//
//  Created by Dingbang Chen on 11/22/23.
//

import Foundation
struct OrderDto: Codable{
    let orderId: String
    let machineName: String
    let moneyForNow: Double
    let timeForNow: Double
}

