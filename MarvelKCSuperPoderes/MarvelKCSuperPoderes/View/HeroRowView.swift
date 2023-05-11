//
//  HeroRowView.swift
//  MarvelKCSuperPoderes
//
//  Created by Markel Juaristi on 11/5/23.
//

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
