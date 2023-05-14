//
//  HerosListView.swift
//  MarvelKCSuperPoderes
//
//  Created by Markel Juaristi on 10/5/23.
//

import SwiftUI

struct HeroListView: View {
    @EnvironmentObject var viewModel: HeroesViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.heroes) { hero in
                    NavigationLink(destination: SeriesListView(viewModel: SeriesViewModel(interactor: SeriesInteractor(), hero: hero))) {
                        HeroRowView(hero: hero)
                    }
                }
            }
            .navigationTitle("Héroes")
            
        }
    }
}

struct HeroListView_Previews: PreviewProvider {
    static var previews: some View {
        HeroListView()
            .environmentObject(HeroesViewModel())
    }
}

