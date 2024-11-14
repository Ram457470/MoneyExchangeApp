//
//  ErrorMessage.swift
//  MoneyExchangeApp
//
//  Created by Ram Naidu on 11/11/24.
//

import Foundation

enum RequestError: String, Error {
    case invalidusers           = "This username created an invalide request. please try again"
    case unableToComplete       = "Unable to complete your request. please check your internet connection"
    case invalidResponse        = "Invalid response from the server. Please try again."
    case invalidData            = "The data received from the server was invalid. Please try again."
    case unableToFavorates      = "There was an error favorating this user. Please try again."
    case alreadyFavorites       = "You're already favorited this user. you must be REALLY like them."
}
