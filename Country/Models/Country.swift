//
//  Country.swift
//  Countries
//
//  Created by Leonardo Modro on 14/12/21.
//

import UIKit

struct Country: Codable {
    var cca2: String
    var name: CountryName
    var tld: [String]?
    var independent: Bool?
    var status: String
    var unMember: Bool
    var currencies: CurrencyList.List?
    var capital: [String]?
    var altSpellings: [String]
    var region: String
    var subregion: String?
//    var languages
    var translations: Translations
    var latlng: [Double]
    var area: Double
    var demonyms: Demonyms?
    var flag: String?
    var population: Int
    var fifa: String?
    var timezones: [String]
    var continents: [String]
    var flags: CountryFlag
    var coatOfArms: CountryArms
    
    struct CountryName: Codable {
        var common: String
        var official: String
    }
    
    struct Translations: Codable {
        var ara: TranslationDetail
        var fra: TranslationDetail
//        var jpn: TranslationDetail
        var por: TranslationDetail
        var rus: TranslationDetail
        var spa: TranslationDetail
        
        struct TranslationDetail: Codable {
            var official: String
            var common: String
        }
    }
    
    struct Demonyms: Codable {
        var eng: DemonymsLanguage
        
        struct DemonymsLanguage: Codable {
            var f: String
            var m: String
        }
    }
    
    struct CountryFlag: Codable {
        var png: String
        var svg: String
    }
    
    struct CountryArms: Codable {
        var png: String?
        var svg: String?
    }
}

extension Country: Identifiable {
    var id: String { return cca2 }
}

//MARK: - Currency
//struct Currency: Codable {
//    var value: String
//}

struct CurrencyList: Codable {
    var code: String
    var symbol: String
    var name: String
}

extension CurrencyList {
    struct List: Codable {
        let values: [CurrencyList]

        init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
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
