//
//  SeriesListView.swift
//  MarvelKCSuperPoderes
//
//  Created by Markel Juaristi on 12/5/23.
//
import Foundation
import Combine
import SwiftUI


struct SeriesListView: View {
    @ObservedObject var viewModel: SeriesViewModel

    var body: some View {
        List {
            ForEach(viewModel.series) { serie in
                SerieRowView(serie: serie)
            }
        }
        .navigationTitle("Series de \(viewModel.hero.name)")
    }
}

struct SeriesListView_Previews: PreviewProvider {
    static var previews: some View {
        let seriesInteractor = SeriesInteractor()
        let hero = Hero(id: 1, name: "Iron Man", description: "Hero description", thumbnail: HeroeThumbnail(path: "image_path", thumbnailExtension: "jpg"))
        let viewModel = SeriesViewModel(interactor: seriesInteractor, hero: hero)
        
        SeriesListView(viewModel: viewModel)
    }
}
