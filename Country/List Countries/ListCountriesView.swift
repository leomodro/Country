//
//  ListCountryView.swift
//  Country
//
//  Created by Leonardo Modro on 14/12/21.
//

import SwiftUI

struct ListCountriesView: View {
    
    @ObservedObject private var viewModel = ListCountryViewModel()
    @State private var searchText = ""
    var searchedCountries: [Country] {
        if searchText.isEmpty {
            return viewModel.countries
        } else {
            return viewModel.countries.filter { item in
                if item.name.common.localizedCaseInsensitiveContains(searchText) || (item.capital != nil && item.capital!.first!.localizedCaseInsensitiveContains(searchText)) {
                    return true
                }
                return false
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List(searchedCountries) { country in
                NavigationLink(destination: CountryView(viewModel: CountriesViewModel(country: country))) {
                    HStack(spacing: 10) {
                        Text(country.flag ?? "")
                            .font(.largeTitle)
                        VStack(alignment: .leading, spacing: 3) {
                            Text(country.name.common)
                                .font(.headline)
                            Text(country.capital?.first ?? "Capital unavailable")
                                .font(.subheadline)
                                .foregroundColor(Color.secondary)
                        }
                    }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                }
            }
            .searchable(text: $searchText, prompt: "Search for country or capital")
            .navigationTitle("Countries")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ListCountryView_Previews: PreviewProvider {
    static var previews: some View {
        ListCountriesView()
        ListCountriesView().preferredColorScheme(.dark)
    }
}
