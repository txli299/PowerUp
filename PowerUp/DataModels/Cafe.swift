//
//  Cafe.swift
//  PowerUp
//
//  Created by Nicholas Letarte on 11/18/23.
//

import Foundation

struct Cafe: Codable {
    var id: String
    var name: String
    var coordinate: Coordinate
    var machines: [Machine]
    var distance: Double
}
