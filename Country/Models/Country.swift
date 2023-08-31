//
//  Country.swift
//  Countries
//
//  Created by Leonardo Modro on 14/12/21.
//

import UIKit
import CoreLocation

struct Country: Codable {
    var cca2: String
    var name: CountryName
    var tld: [String]?
    var independent: Bool?
    var status: String
    var unMember: Bool
    var currencies: CurrencyList.List?
    var idd: Idd
    var capital: [String]?
    var region: String
    var subregion: String?
    var languages: Languages.List?
    var translations: Translations
    var latlng: [Double]
    var area: Double
    var flag: String?
    var population: Int
    var fifa: String?
    var timezones: [String]
    var continents: [String]
    var flags: CountryFlag
    
    struct CountryName: Codable {
        var common: String
        var official: String
    }
    
    struct Idd: Codable {
        var root: String?
    }
    
    struct Translations: Codable {
        var ara: TranslationDetail
        var fra: TranslationDetail
        var por: TranslationDetail
        var rus: TranslationDetail
        var spa: TranslationDetail
        
        struct TranslationDetail: Codable {
            var official: String
            var common: String
        }
    }
    
    struct CountryFlag: Codable {
        var png: String
        var svg: String
    }
}

extension Country: Identifiable {
    var id: String { return cca2 }
}

struct Coordinate: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

//MARK: - Currency
struct CurrencyList: Codable {
    var code: String
    var symbol: String
    var name: String
}

extension CurrencyList {
    struct List: Codable {
        let values: [CurrencyList]

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let dictionary = try container.decode([String : [String: String]].self)

            values = dictionary.map { key, value in
                let symbol = value["symbol"] ?? ""
                let name = value["name"] ?? ""
                return CurrencyList(code: key, symbol: symbol, name: name)
            }
        }
    }
}

// MARK: - Languages
struct Languages: Codable {
    var key: String
    var name: String
}

extension Languages {
    struct List: Codable {
        let values: [Languages]

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let dictionary = try container.decode([String : String].self)

            values = dictionary.map { key, value in
                return Languages(key: key, name: value)
            }
        }
    }
}
