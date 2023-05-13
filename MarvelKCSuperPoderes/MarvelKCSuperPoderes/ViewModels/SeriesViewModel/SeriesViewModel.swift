//
//  SeriesViewModel.swift
//  MarvelKCSuperPoderes
//
//  Created by Markel Juaristi on 12/5/23.
//

import Foundation
import Combine

class SeriesViewModel: ObservableObject {
    @Published var series = [Serie]()
    let interactor: SeriesInteractorProtocol
    let hero: Hero

    private var cancellables = Set<AnyCancellable>()

    init(interactor: SeriesInteractorProtocol, hero: Hero) {
        self.interactor = interactor
        self.hero = hero
        getSeries()
    }

    func getSeries() {
        interactor.getSeries(for: hero, limit: 5)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    print("Finished")
                }
            }, receiveValue: { [weak self] series in
                self?.series = series
            })
            .store(in: &cancellables)
    }
}
