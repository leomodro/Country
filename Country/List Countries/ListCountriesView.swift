//
//  ListCountryView.swift
//  Country
//
//  Created by Leonardo Modro on 14/12/21.
//

import SwiftUI

struct ListCountriesView: View {
    
    @ObservedObject private var viewModel = ListCountryViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.searchedCountries) { country in
                NavigationLink(destination: CountryView(viewModel: CountriesViewModel(country: country))) {
                    HStack(spacing: 10) {
                        Text(country.flag ?? "")
                            .font(.largeTitle)
                        VStack(alignment: .leading, spacing: 3) {
                            Text(country.name.common)
                                .font(.headline)
                            Text(country.capital?.first ?? "Capital unavailable")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search for country or capital")
            .navigationTitle("Countries")
            .onChange(of: viewModel.searchText) { _ in
                viewModel.performSearch()
            }
            .task {
                await viewModel.fetchCountries()
            }
        }
    }
}

//MARK: - Previews
struct ListCountryView_Previews: PreviewProvider {
    static var previews: some View {
        ListCountriesView()
        ListCountriesView().preferredColorScheme(.dark)
    }
}
