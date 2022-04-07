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

//MARK: - Generate data
extension Country {
    static func generateCountry() -> Country {
        return Country(cca2: "BR", name: CountryName(common: "Brazil", official: "Federative Republic of Brazil"), tld: [".br"], independent: true, status: "officially-assigned", unMember: true, currencies: nil, capital: ["Brasília"], altSpellings: ["BR", "Brasil"], region: "Americas", subregion: "South America", translations: Translations(ara: Translations.TranslationDetail(official: "", common: ""), fra: Translations.TranslationDetail(official: "", common: ""), por: Translations.TranslationDetail(official: "", common: ""), rus: Translations.TranslationDetail(official: "", common: ""), spa: Translations.TranslationDetail(official: "", common: "")), latlng: [-10.0, -55.0], area: 8515767.0, demonyms: Demonyms(eng: Demonyms.DemonymsLanguage(f: "Brazilian", m: "Brazilian")), flag: "🇧🇷", population: 212559409, fifa: "BRA", timezones: ["UTC-05:00"], continents: ["South America"], flags: CountryFlag(png: "https://flagcdn.com/w320/br.png", svg: "https://flagcdn.com/br.svg"), coatOfArms: CountryArms(png: "https://mainfacts.com/media/images/coats_of_arms/br.png", svg: ""))
    }
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
