//
//  Country.swift
//  Countries
//
//  Created by MiciH on 4/13/21.
//

import Foundation

struct Country: Codable {
    let name: String
    let nativeName: String
    let area: Double?
    let borders: [String]
    let alpha3Code: String
}
