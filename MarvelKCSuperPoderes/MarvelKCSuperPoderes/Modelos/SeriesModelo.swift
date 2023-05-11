//
//  SeriesModelo.swift
//  MarvelKCSuperPoderes
//
//  Created by Markel Juaristi on 25/3/23.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)


import Foundation

struct SerieWelcome: Codable {
    let data: SerieDataClass
}

struct SerieDataClass: Codable {
    let results: [Serie]
}

struct Serie: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: SerieThumbnail
}

struct SerieThumbnail: Codable {
    let path: String
    let thumbnailExtension: String?

    enum SerieCodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
