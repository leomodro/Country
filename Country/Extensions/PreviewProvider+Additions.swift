//
//  PreviewProvider+Additions.swift
//  Country
//
//  Created by Leonardo Modro on 30/08/23.
//

import SwiftUI

extension PreviewProvider {
    
//#if DEBUG
    
//    static var fipeValueViewModel: FipeValueViewModel {
//        FipeValueViewModel(fipeService, dataStoreManager: dataStoreManager, fipeValue: fipeValue)
//    }
    
    static var countries: [Country] {
        do {
            let response: [Country]? = try JSONLoader().load(.countries)
            return response ?? []
        } catch {
            fatalError("Failed loading json data \(error)")
        }
    }
    
    static var randomCountry: Country {
        do {
            let response: [Country]? = try JSONLoader().load(.countries)
            if let country = response?.randomElement() {
                return country
            }
            fatalError("Unable to generate random country")
        } catch {
            fatalError("Failed loading json data \(error)")
        }
    }
//#endif
}
