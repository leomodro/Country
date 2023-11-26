//
//  CountriesViewModel.swift
//  Countries
//
//  Created by Leonardo Modro on 14/12/21.
//

import SwiftUI
import CoreLocation

final class CountriesViewModel: ObservableObject {
    
    let country: Country
    
    // MARK: - Computed variables
    var capital: String {
        country.capital?.first ?? "Not available"
    }
    
    var currency: String {
        if let currency = country.currencies {
            let symbol = currency.values[0].symbol
            let name = currency.values[0].name
            return symbol + " - " + name
        }
        return "Not available"
    }
    
    var continent: String {
        country.continents[0]
    }
    
    var area: String {
        country.area.countryAreaFormat() + " km²"
    }
    
    var independent: String {
        country.independent != nil && country.independent! ? "Yes" : "No"
    }
    
    var unMember: String {
        country.unMember ? "Yes" : "No"
    }
    
    var idd: String {
        country.idd.root ?? "Not available"
    }
    
    var langagues: String {
        if let lang = country.languages {
            return lang.values
                .map { $0.name }
                .joined(separator: ", ")
        }
        return ""
    }
    
    var timezones: String {
        return country.timezones.joined(separator: ", ")
    }
    
    var countryCoordinates: Coordinate {
        let lat = country.latlng[0]
        let lon = country.latlng[1]
        return Coordinate(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
    }
    
    // MARK: - Init
    init(country: Country) {
        self.country = country
    }
    
}
