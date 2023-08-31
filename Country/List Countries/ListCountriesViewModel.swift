//
//  ListCountriesViewModel.swift
//  Country
//
//  Created by Leonardo Modro on 14/12/21.
//

import SwiftUI

enum FetchError: Error {
    case invalidURL
    case missingData
}

final class ListCountryViewModel: ObservableObject {
    
    @Published var countries: [Country] = []
    
    init() {
        
        Task {
            do {
                let resp = try await fetchCountries()
                DispatchQueue.main.async {
                    self.countries = resp.sorted(by: { $0.name.common < $1.name.common })
                }
            } catch let err {
                print(err)
            }
        }
        
    }
    
    public func fetchCountries() async throws -> [Country] {
        guard let url = URL(string: "https://restcountries.com/v3.1/all") else { throw FetchError.invalidURL }
        let (data, _) = try await URLSession.shared.data(from: url)
        let resp = try JSONDecoder().decode([Country].self, from: data)
        return resp
    }
    
}
