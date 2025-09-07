//
//  SwiftUIView.swift
//  ClutchSelectFavTeamModule
//
//  Created by Engin Gülek on 7.09.2025.
//

import SwiftUI

import SwiftUI

struct League: Identifiable {
    let id = UUID()

    let name: String
}

struct Country: Identifiable {
    let id = UUID()
    let name: String
    let imageName:ImageResource
    let leagues: [League]
}

struct CountryListView: View {
    let countries: [Country] = [
        Country(name: "İspanya", imageName: .spain, leagues: [
            League(name: "La Liga (1. Lig)"),
            League(name: "La Liga 2 (2. Lig)")
        ]),
        Country(name: "İngiltere", imageName: .england, leagues: [
            League(name: "Premier League (1. Lig)"),
            League(name: "Championship (2. Lig)")
        ]),
        
        Country(name: "Türkiye", imageName: .türkiye, leagues: [
            League(name: "Süper Lig (1. Lig)"),
            League(name: "1. Lig (2. Lig)")
        ])
    ]
    
    @State private var expandedCountry: UUID?

    var body: some View {
        NavigationView {
            List {
                ForEach(countries) { country in
                    DisclosureGroup(
                        isExpanded: Binding(
                            get: { expandedCountry == country.id },
                            set: { expandedCountry = $0 ? country.id : nil }
                        )
                    ) {
                        ForEach(country.leagues) { league in
                          
                             
                                Text(league.name)
                                    .padding(.leading, 10)
                            
                           
                        }
                    } label: {
                        HStack {
                            Image(country.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40, alignment: .center)
                            Text(country.name)
                                .font(.headline)
                        }
                       
                    }
                }
            }
            .navigationTitle("Futbol Ligleri")
        }
    }
}


#Preview {
    CountryListView()
}
