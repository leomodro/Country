//
//  ListCountriesViewModel.swift
//  Country
//
//  Created by Leonardo Modro on 14/12/21.
//

import SwiftUI

@MainActor
final class ListCountryViewModel: ObservableObject {
    
    @Published var countries: [Country] = []
    @Published var searchText = ""
    @Published var searchedCountries: [Country] = []
    
    init() { }
    
    public func fetchCountries() async {
        guard let url = URL(string: "https://restcountries.com/v3.1/all") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let resp = try JSONDecoder().decode([Country].self, from: data)
            handleResponseData(resp)
        } catch {
            if let resp: [Country] = try? JSONLoader().load(.countries) {
                handleResponseData(resp)
            }
        }
    }
    
    private func handleResponseData(_ resp: [Country]) {
        self.countries = resp.sorted(by: { $0.name.common < $1.name.common })
        performSearch()
    }
    
    func performSearch() {
        if searchText.isEmpty {
            self.searchedCountries = countries
        } else {
            self.searchedCountries = countries.filter { item in
                if item.name.common.localizedCaseInsensitiveContains(searchText) || (item.capital != nil && item.capital!.first!.localizedCaseInsensitiveContains(searchText)) {
                    return true
                }
                return false
            }
        }
    }
    
}
