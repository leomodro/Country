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
            return viewModel.countries.filter({ $0.name.common.localizedCaseInsensitiveContains(searchText) })
        }
    }
    
    var body: some View {
        NavigationView {
            List(searchedCountries) { country in
                NavigationLink(destination: CountryView(country: country)) {
                    HStack {
//                        AsyncImage(
//                            url: URL(string: country.flags.png),
//                            content: { image in
//                                image
//                                    .resizable()
//                                    .cornerRadius(25)
//                                    .frame(maxWidth: 50, maxHeight: 50)
////                                    .aspectRatio(contentMode: .fill)
//                            },
//                            placeholder: {
//                                ProgressView()
//                            }
//                        )
                        Text(country.flag ?? "")
                            .font(.largeTitle)
                        Text(country.name.common)
                            .font(.headline)
                    }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                }
            }
            .searchable(text: $searchText, prompt: "Search")
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
