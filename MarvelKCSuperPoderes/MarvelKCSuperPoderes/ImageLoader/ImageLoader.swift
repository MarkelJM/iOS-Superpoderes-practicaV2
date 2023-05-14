//
//  ImageLoader.swift
//  MarvelKCSuperPoderes
//
//  Created by Markel Juaristi on 12/5/23.
//

import Combine
import SwiftUI

// ImageLoader es una clase que puede avisar cuando cambian cosas. En este caso, nos va a avisar cuando se carga una imagen. PD y Nota para Jose las series tardan demasiado o eso me parece.
class ImageLoader: ObservableObject {
    // La imagen que vamos a cargar. Cuando la imagen cambie, va a avisar a todo el que esté escuchando.
    @Published var image: UIImage?

    // Esto es para poder parar la descarga de la imagen si no hace falta (por ejemplo, si el usuario se va de la pantalla antes de que se termine de descargar).
    private var cancellable: AnyCancellable?

    // Esta función empieza a descargar la imagen desde el internet.
    func load(from url: URL) {
        // Aquí estamos empezando a descargar la imagen.
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            // Convertimos los datos que descargamos a una imagen. Si hay algún problema, este paso falla.
            .map { UIImage(data: $0.data) }
            // Si hay algún problema, no vamos a mostrar ninguna imagen.
            .replaceError(with: nil)
            // Nos aseguramos de que las actualizaciones a la imagen se hacen en el hilo principal. Esto es necesario porque las actualizaciones a la interfaz de usuario deben hacerse en el hilo principal.
            .receive(on: DispatchQueue.main)
            // Aquí estamos diciendo que cuando tengamos la imagen, la vamos a guardar en self.image para poder usarla.
            .sink { [weak self] in self?.image = $0 }
    }

    // Esta función se usa para parar la descarga de la imagen si no hace falta. Lo añado por si acaso, sin mas.
    func cancel() {
        cancellable?.cancel()
    }
}

