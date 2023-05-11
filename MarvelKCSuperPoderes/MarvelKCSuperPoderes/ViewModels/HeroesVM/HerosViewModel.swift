//
//  HerosViewModel.swift
//  MarvelKCSuperPoderes
//
//  Created by Markel Juaristi on 10/5/23.
//

import Foundation
import Combine

// Clase ViewModel que implementa ObservableObject para ser usada en SwiftUI
class HeroesViewModel: ObservableObject {
    // Propiedades publicadas para ser observadas por las vistas
    @Published var heroes: [Hero] = []
    @Published var searchText: String = ""
    @Published var status: Status = .none

    // Almacenamiento para cancelar suscripciones Combine
    private var cancellables: Set<AnyCancellable> = []

    // Referencia al protocolo HeroesInteractorProtocol para obtener los datos de los héroes
    private let interactor: HeroesInteractorProtocol

    // Inicializador del ViewModel
    init(interactor: HeroesInteractorProtocol = HeroesInteractor()) {
        self.interactor = interactor
        setupBindings()
    }

    // Función para configurar los bindings entre propiedades publicadas y métodos
    /* antes private*/
    func setupBindings() {
        // Escucha los cambios en el texto de búsqueda
        $searchText
            // Espera 500 milisegundos antes de procesar nuevos cambios
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            // Elimina duplicados para no realizar búsquedas innecesarias
            .removeDuplicates()
            // Al recibir un nuevo valor en el texto de búsqueda, llama a fetchHeroes
            .sink { [weak self] searchText in
                self?.fetchHeroes(filter: searchText)
            }
            // Almacena la suscripción en el conjunto de cancelables
            .store(in: &cancellables)
    }

    // Función para buscar héroes usando el interactor
    /* antes private*/
    func fetchHeroes(filter: String) {
        // Establece el estado como "cargando"
        status = .loading
        // Llama al interactor para obtener los héroes
        interactor.getHeroes(filter: filter)
            // Procesa la finalización de la llamada al interactor
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching heroes: \(error)")
                    // Establece el estado como "error" si ocurre un error
                    self?.status = .error(error: error.localizedDescription)
                case .finished:
                    // Establece el estado como "cargado" cuando se completa la llamada
                    self?.status = .loaded
                }
            } receiveValue: { [weak self] heroes in
                // Actualiza la propiedad "heroes" con los héroes obtenidos
                self?.heroes = heroes
            }
            // Almacena la suscripción en el conjunto de cancelables
            .store(in: &cancellables)
    }
    /* para el test*/
    func loadSampleData() {
            let thumbnail = HeroeThumbnail(path: "testPath", thumbnailExtension: "testExtension")
            let sampleHero = Hero(id: 1, name: "TestHero", description: "TestDescription", thumbnail: thumbnail)
            
            self.heroes = [sampleHero]
        }
}

