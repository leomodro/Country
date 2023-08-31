//
//  ContentView.swift
//  Country
//
//  Created by Leonardo Modro on 14/12/21.
//

import SwiftUI
import MapKit

struct CountryView: View {
    @ObservedObject var viewModel: CountriesViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                countryFlag
                
                VStack(alignment: .leading) {
                    Group {
                        countryInfo(title: "Official Name:", subtitle: viewModel.country.name.official)
                        countryInfo(title: "Capital:", subtitle: viewModel.capital)
                        countryInfo(title: "Currency:", subtitle: viewModel.currency)
                        countryInfo(title: "Continent:", subtitle: viewModel.continent)
                        countryInfo(title: "Region:", subtitle: viewModel.country.region)
                    }
                    
                    Group {
                        countryInfo(title: "Area:", subtitle: viewModel.area)
                        countryInfo(title: "Population:", subtitle: "\(viewModel.country.population.formatted(.number))")
                        countryInfo(title: "Languages:", subtitle: viewModel.langagues)
                    }
                    
                    Group {
                        countryInfo(title: "Independent:", subtitle: viewModel.independent)
                        countryInfo(title: "UN Member:", subtitle: viewModel.unMember)
                        countryInfo(title: "IDD:", subtitle: viewModel.idd)
                        countryInfo(title: "Timezones:", subtitle: viewModel.timezones)
                    }
                }
                
                mapView
            }
            .navigationTitle(viewModel.country.name.common)
            .padding(.vertical, 25)
            .padding(.horizontal, 16)
        }
    }
}

// MARK: - View components
extension CountryView {
    var countryFlag: some View {
        AsyncImage(url: URL(string: viewModel.country.flags.png)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .cornerRadius(24)
                .padding(.bottom, 16)
        } placeholder: {
            ProgressView()
                .frame(minWidth: 0, maxWidth: .infinity)
        }
    }
    
    @ViewBuilder
    func countryInfo(title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .fontWeight(.medium)
                .foregroundColor(.gray)
            Text(subtitle)
                .font(.title3)
                .fontWeight(.semibold)
        }
        .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))
    }
    
    var mapView: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: viewModel.countryCoordinates.coordinate, span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))), annotationItems: [viewModel.countryCoordinates]) { annotation in
            MapPin(coordinate: annotation.coordinate)
        }
        .cornerRadius(24)
        .frame(height: 300, alignment: .center)
        .padding(.top, 16)
    }
}

//MARK: - Previews
struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(viewModel: CountriesViewModel(country: randomCountry))
        CountryView(viewModel: CountriesViewModel(country: randomCountry))
            .preferredColorScheme(.dark)
    }
}
