//
//  ErrorMessage.swift
//  Culturetrip
//
//  Created by MiciH on 4/10/21.
//

import Foundation

enum CTError: String, Error {
    case domainError = "The url is invalid"
    case InternetError = "Please check your internet connection"
    case dataError = "Error in receiving the data"
    case decodingError = "Error in decoding"
}
