//
//  ContentView.swift
//  Country
//
//  Created by Leonardo Modro on 14/12/21.
//

import SwiftUI

struct CountryView: View {
    
    @ObservedObject private var viewModel = CountriesViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                if viewModel.country == nil {
                    ProgressView("Fetching")
                        .frame(width: 120, height: 120, alignment: Alignment.center)
                } else {
                    AsyncImage(url: URL(string: viewModel.country.flags.png))
                    Text(viewModel.country.name.common)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Official Name:")
                                .fontWeight(.semibold)
                            Text(viewModel.country.name.official)
                        }.padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                        HStack() {
                            Text("Capital:")
                                .fontWeight(.semibold)
                            Text(viewModel.country.capital.first ?? "Not available")
                        }.padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                        HStack() {
                            Text("Independent:")
                                .fontWeight(.semibold)
                            Text(viewModel.country.independent ? "Yes" : "No")
                        }.padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                        HStack() {
                            Text("Region:")
                                .fontWeight(.semibold)
                            Text(viewModel.country.region)
                        }.padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                        HStack() {
                            Text("Subregion:")
                                .fontWeight(.semibold)
                            Text(viewModel.country.subregion)
                        }.padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                        HStack() {
                            Text("Area:")
                                .fontWeight(.semibold)
                            Text(viewModel.country.area.countryAreaFormat() + " km²")
                        }.padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                        HStack() {
                            Text("Population:")
                                .fontWeight(.semibold)
                            Text("\(viewModel.country.population)")
                        }.padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                    }
                }
            }
        }
    }
}

extension Double {
    func countryAreaFormat() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "Not available"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView()
    }
}
