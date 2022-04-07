//
//  ContentView.swift
//  Country
//
//  Created by Leonardo Modro on 14/12/21.
//

import SwiftUI
import MapKit

struct CountryView: View {
    var country: Country
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: country.flags.png))
                VStack(alignment: .leading) {
                    HStack {
                        Text("Official Name:")
                            .fontWeight(.semibold)
                        Text(country.name.official)
                    }.padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
                    HStack() {
                        Text("Capital:")
                            .fontWeight(.semibold)
                        Text(country.capital?.first ?? "Not available")
                    }.padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                    HStack() {
                        Text("Currency:")
                            .fontWeight(.semibold)
                        if let currency = country.currencies {
                            let symbol = currency.values[0].symbol
                            let name = currency.values[0].name
                            Text(symbol + " - " + name)
                        } else {
                            Text("Not available")
                        }
                    }.padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                    HStack() {
                        Text("Continent:")
                            .fontWeight(.semibold)
                        Text(country.continents[0])
                    }.padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                    HStack() {
                        Text("Region:")
                            .fontWeight(.semibold)
                        Text(country.region)
                    }.padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                    HStack() {
                        Text("Area:")
                            .fontWeight(.semibold)
                        Text(country.area.countryAreaFormat() + " km²")
                    }.padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                    HStack() {
                        Text("Population:")
                            .fontWeight(.semibold)
                        Text("\(country.population)")
                    }.padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                    HStack() {
                        Text("Independent:")
                            .fontWeight(.semibold)
                        Text(country.independent != nil && country.independent! ? "Yes" : "No")
                    }.padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                    HStack() {
                        Text("UN Member:")
                            .fontWeight(.semibold)
                        Text(country.unMember ? "Yes" : "No")
                    }.padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
                }
            }
            .navigationTitle(country.name.common)
            .padding(.vertical, 25)
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

//MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(country: Country.generateCountry())
        CountryView(country: Country.generateCountry()).preferredColorScheme(.dark)
    }
}
