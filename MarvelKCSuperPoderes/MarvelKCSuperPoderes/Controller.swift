//
//  Controller.swift
//  MarvelKCSuperPoderes
//
//  Created by Markel Juaristi on 11/5/23.
//

import SwiftUI

struct StatusControllerView: View {
    // La ViewModel se define como una variable de entorno que se inyecta en AppDelegate
    @EnvironmentObject var viewModel: HeroesViewModel

    var body: some View {
        Group {
            switch viewModel.status {
            case .none:
                // No se ha realizado ninguna operación aún, podemos mostrar un estado inicial o nada
                Text("Busca un superhéroe en el cuadro de búsqueda").padding()
            case .loading:
                // Muestra una vista de carga mientras se obtienen los datos
                LoadingView()
            case .loaded:
                // Cuando los datos estén cargados, muestra la lista de héroes
                HeroListView()
            case .error(let errorString):
                // Si hay un error, se muestra un mensaje de error
                Text("Error: \(errorString)")
            default:
                // Caso por defecto para estados adicionales que podrías tener
                EmptyView()
            }
        }
        .onAppear(perform: {
            // Cuando la vista aparece por primera vez, si no hay datos cargados, inicia una carga
            if viewModel.heroes.isEmpty {
                viewModel.fetchHeroes(filter: "")
            }
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        StatusControllerView()
            .preferredColorScheme(.dark)
            .environmentObject(HeroesViewModel())
    }
}

