//
//  HeroRowView.swift
//  MarvelKCSuperPoderes
//
//  Created by Markel Juaristi on 11/5/23.
//

import SwiftUI


struct HeroRowView: View {
    let hero: Hero
    @StateObject var imageLoader = ImageLoader()
    
    var body: some View {
        HStack {
            // Intenta crear una URL a partir de las propiedades del héroe
            if let url = URL(string: "\(hero.thumbnail.path).\(hero.thumbnail.thumbnailExtension ?? "")") {
                // Comprueba si la imagen se ha cargado
                if let image = imageLoader.image {
                    // Si la imagen se ha cargado, muéstrala
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                } else {
                    // Si la imagen aún no se ha cargado, muestra una vista de carga
                    /* FYI Jose: si la ruta no incluye una barra al final, la URL resultante no será válida, debido a que al traer la imagen nosotros indicamos path*/
                    ProgressView()
                }
            } else {
                // Si la URL no es válida, muestra una imagen de marcador de posición
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
            }
            
            // Aquí se muestra el nombre del héroe
            Text(hero.name)
                .font(.title2)
                .padding(.leading)
            
            
            Spacer()
        }
        .padding()
        .onAppear {
            if let url = URL(string: "\(hero.thumbnail.path).\(hero.thumbnail.thumbnailExtension ?? "")"),
               imageLoader.image == nil {
                imageLoader.load(from: url)
            }
        }
        .onDisappear {
            // Cancela la carga de la imagen cuando la vista desaparezca
            imageLoader.cancel()
        }
    }
    
    
}

struct HeroRowView_Previews: PreviewProvider {
    static var previews: some View {
        HeroRowView(hero: Hero(id: 1, name: "Spider-Man", description: "Spider-Man", thumbnail: HeroeThumbnail(path: "", thumbnailExtension: "")))
            .previewLayout(.sizeThatFits)
    }
}


/*
struct HeroRowView: View {
    let hero: Hero

    var body: some View {
        HStack {
            // Aquí se muestra la imagen del héroe
            if let url = URL(string: "\(hero.thumbnail.path).\(hero.thumbnail.thumbnailExtension ?? "")"),
               let imageData = try? Data(contentsOf: url),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            }

            // Aquí se muestra el nombre del héroe
            Text(hero.name)
                .font(.title2)
                .padding(.leading)

            Spacer()
        }
        .padding()
    }
}

struct HeroRowView_Previews: PreviewProvider {
    static var previews: some View {
        HeroRowView(hero: Hero(id: 1, name: "Spider-Man", description: "Spider-Man", thumbnail: HeroeThumbnail(path: "", thumbnailExtension: "")))
            .previewLayout(.sizeThatFits)
    }
}

*/
















///VERSION DONDE MOSTRARA HASTA LOS QUE NO TENGAS FOTO
/*
import SwiftUI

struct HeroRowView: View {
    let hero: Hero

    var body: some View {
        HStack {
            // Aquí se muestra la imagen del héroe
            if let url = URL(string: "\(hero.thumbnail.path).\(hero.thumbnail.thumbnailExtension ?? "")"),
               let imageData = try? Data(contentsOf: url),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
            }

            // Aquí se muestra el nombre del héroe
            Text(hero.name)
                .font(.title2)
                .padding(.leading)

            Spacer()
        }
        .padding()
    }
}

struct HeroRowView_Previews: PreviewProvider {
    static var previews: some View {
        HeroRowView(hero: Hero(id: 1, name: "Spider-Man", description: "Spider-Man", thumbnail: HeroeThumbnail(path: "", thumbnailExtension: "")))
            .previewLayout(.sizeThatFits)
    }
}
*/
