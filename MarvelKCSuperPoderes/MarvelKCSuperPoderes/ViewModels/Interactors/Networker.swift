//
//  Networker.swift
//  MarvelKCSuperPoderes
//
//  Created by Markel Juaristi on 28/3/23.
//

import Foundation
import Combine
/* esto permite una separación clara entre la lógica de red y la lógica de negocio en una aplicación, lo que facilita la escalabilidad y el mantenimiento del código*/

protocol NetworkerProtocol: AnyObject {
    // Este método realiza una llamada a la API y devuelve los datos decodificados en un AnyPublisher.
    func callServer<T>(type: T.Type, request: URLRequest) -> AnyPublisher<T, Error> where T: Decodable
}

// NetWorker es una implementación  del NetworkerProtocol.
final class NetWorker: NetworkerProtocol {
    // La función callServer realiza una llamada a la API usando la URLRequest proporcionada y devuelve los datos decodificados en un AnyPublisher.
    func callServer<T>(type: T.Type, request: URLRequest) -> AnyPublisher<T, Error> where T: Decodable {
        URLSession.shared
            .dataTaskPublisher(for: request) // Realiza la llamada a la API.
            .tryMap {
                // Verifica que la respuesta 
                guard let response = $0.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return $0.data // Devuelve los datos recibidos.
            }
            .decode(type: T.self, decoder: JSONDecoder()) // Decodifica los datos en el tipo esperado.
            .receive(on: DispatchQueue.main) // Entrega los datos en el hilo principal.
            .eraseToAnyPublisher() // Oculta detalles sobre el tipo de publicador subyacente.
    }

}
