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
        NavigationView {
            List(viewModel.countries) { country in
                NavigationLink(destination: CountryView(country: country)) {
                    HStack {
    //                    AsyncImage(
    //                        url: URL(string: country.flags.png),
    //                        content: { image in
    //                            image
    //                                .resizable()
    //                                .aspectRatio(contentMode: .fit)
    //                                .frame(maxWidth: 100, maxHeight: 100)
    //                        },
    //                        placeholder: {
    //                            ProgressView()
    //                        }
    //                    )
                        Text(country.flag)
                            .font(.largeTitle)
                        Text(country.name.common)
                            .font(.headline)
                    }.padding(EdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5))
                }
            }
            .navigationTitle("Countries")
        }
    }
}

struct ListCountryView_Previews: PreviewProvider {
    static var previews: some View {
        ListCountriesView()
        ListCountriesView().preferredColorScheme(.dark)
    }
}
