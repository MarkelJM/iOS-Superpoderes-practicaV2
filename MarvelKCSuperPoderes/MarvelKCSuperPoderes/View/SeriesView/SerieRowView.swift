//
//  SerieRowView.swift
//  MarvelKCSuperPoderes
//
//  Created by Markel Juaristi on 12/5/23.
//

import SwiftUI

struct SerieRowView: View {
    let serie: Serie
    // Creamos una instancia del ImageLoader
    @StateObject var imageLoader = ImageLoader()

    var body: some View {
        HStack {
            // Intentamos crear una URL para la imagen de la serie
        let imagePath = serie.thumbnail.path.hasSuffix("/") ? serie.thumbnail.path : serie.thumbnail.path + "/"
                   let imageURLString = "\(imagePath)\(serie.thumbnail.thumbnailExtension ?? "")"
                   if let url = URL(string: imageURLString) {
                       // Si la imagen ya se ha cargado, la mostramos
                       if let image = imageLoader.image {
                           Image(uiImage: image)
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(width: 100, height: 100)
                       } else {
                           // Si la imagen no se ha cargado aún, mostramos una vista de carga
                           ProgressView()
                       }
                   } else {
                // Si no podemos crear la URL, mostramos una imagen de marcador de posición
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
            }

            VStack(alignment: .leading) {
                // Mostramos el título de la serie
                Text(serie.title)
                    .font(.title2)
                    .padding(.leading)
                // Mostramos la descripción de la serie
                /* nose porqué, epro no me lo muestra*/
                Text(serie.description ?? "No hay descripción")
                    .font(.body)
                    .padding(.leading)
            }
            Spacer()
        }
        .padding()
        .onAppear {
            // Cuando la vista aparece, si la imagen no se ha cargado aún, intentamos cargarla
            if let url = URL(string: "\(serie.thumbnail.path).\(serie.thumbnail.thumbnailExtension ?? "")"),
               imageLoader.image == nil {
                imageLoader.load(from: url)
            }
        }
        .onDisappear {
            // Cuando la vista desaparece, cancelamos la carga de la imagen
            imageLoader.cancel()
        }
    }
}




struct SerieRowView_Previews: PreviewProvider {
    static var previews: some View {
        let serie = Serie(id: 1, title: "Avengers", description: "Serie description", thumbnail: SerieThumbnail(path: "image_path", thumbnailExtension: "jpg"))
        
        SerieRowView(serie: serie)
    }
}

