//
//  CountriesViewModel.swift
//  Countries
//
//  Created by Leonardo Modro on 14/12/21.
//

import SwiftUI

enum FetchError: Error {
    case invalidURL
    case missingData
}

final class CountriesViewModel: ObservableObject {
    
    @Published var country: Country!
    
    init() {
        
        Task {
            do {
                let resp = try await fetchCountry()
                DispatchQueue.main.async {
                    self.country = resp
                }
            } catch let err {
                print(err)
            }
        }
        
    }
    
    public func fetchCountry() async throws -> Country {
        guard let url = URL(string: "https://restcountries.com/v3.1/name/brazil") else { throw FetchError.invalidURL }
        let (data, _) = try await URLSession.shared.data(from: url)
        let resp = try JSONDecoder().decode([Country].self, from: data)
        return resp.first!
    }
    
}
