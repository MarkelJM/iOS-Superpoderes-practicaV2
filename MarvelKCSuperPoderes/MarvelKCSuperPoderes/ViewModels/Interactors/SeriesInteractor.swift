//
//  SeriesInteractor.swift
//  MarvelKCSuperPoderes
//
//  Created by Markel Juaristi on 12/5/23.
//
import Foundation
import Combine


/* lo mismo que heroesInteractor que ya tiene comentarios*/
protocol SeriesInteractorProtocol: AnyObject {
    func getSeries(for hero: Hero, limit: Int) -> AnyPublisher<[Serie], Error>
}

final class SeriesInteractor: SeriesInteractorProtocol {
    let networker: NetworkerProtocol
    let marvelAPI: MarvelAPI

    init(network: NetworkerProtocol = NetWorker(), marvelAPI: MarvelAPI = MarvelAPI()) {
        self.networker = network
        self.marvelAPI = marvelAPI
    }

    func getSeries(for hero: Hero, limit: Int) -> AnyPublisher<[Serie], Error> {
        return networker.callServer(type: SerieWelcome.self, request: marvelAPI.getSeriesRequest(for: hero, limit: limit))
            .map { $0.data.results }
            .eraseToAnyPublisher()
    }
}
