//
//  CountryModel.swift
//  MoneyExchangeApp
//
//  Created by Ram Naidu on 11/11/24.
//

import Foundation

// MARK: - Countries List Model

struct CountryListModel: Decodable {
    let flags: Flags?
    let name: Name?
    let cca2, cioc: String?
    let currencies: [String: Currency]?
    let capital: [String]?
    let languages: [String: String]?
}

// MARK: - Currency
struct Currency: Decodable {
    let name, symbol: String?
}

// MARK: - Flags
struct Flags: Decodable {
    let png: String?
    let svg: String?
    let alt: String?
}

// MARK: - Name
struct Name: Decodable {
    let common, official: String?
    let nativeName: [String: NativeName]?
}

// MARK: - NativeName
struct NativeName: Decodable {
    let official, common: String?
}

struct CountryItem {
    let name: String
    let imageName: String
    let buttonImageName: String
}
