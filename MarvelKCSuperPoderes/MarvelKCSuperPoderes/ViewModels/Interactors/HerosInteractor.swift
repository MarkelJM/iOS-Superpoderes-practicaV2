//
//  HerosInteractor.swift
//  MarvelKCSuperPoderes
//
//  Created by Markel Juaristi on 28/3/23.
//

import Foundation
import Combine

// Protocolo
protocol HeroesInteractorProtocol: AnyObject {
    func getHeroes(filter: String) -> AnyPublisher<[Hero], Error>
}

// Clase Interactor REAL
final class HeroesInteractor: HeroesInteractorProtocol {
    let networker: NetworkerProtocol
    let marvelAPI: MarvelAPI

    init(network: NetworkerProtocol = NetWorker(), marvelAPI: MarvelAPI = MarvelAPI()) {
        self.networker = network
        self.marvelAPI = marvelAPI
    }

    func getHeroes(filter: String) -> AnyPublisher<[Hero], Error> {
        return networker.callServer(type: HeroeWelcome.self, request: marvelAPI.getHeroesRequest())
            .map { $0.data.results }
            .eraseToAnyPublisher()
    }
}

