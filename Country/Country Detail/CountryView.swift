//
//  ContentView.swift
//  Country
//
//  Created by Leonardo Modro on 14/12/21.
//

import SwiftUI
import MapKit

struct CountryView: View {
    
//    @ObservedObject private var viewModel = CountriesViewModel()
//    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    var country: Country
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: country.flags.png))
//                Map(coordinateRegion: $region)
//                    .frame(width: 400, height: 300)
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

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CountryView()
//    }
//}
