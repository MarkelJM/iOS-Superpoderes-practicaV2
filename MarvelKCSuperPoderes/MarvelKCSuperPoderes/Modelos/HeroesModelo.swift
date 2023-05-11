//
//  HeroesModelo.swift
//  MarvelKCSuperPoderes
//
//  Created by Markel Juaristi on 25/3/23.
//




// MARK: - Resul

/*
struct Heroe: Codable {
    let id, name, description, modified: String
    let resourceURI: String
    let urls: String
    let thumbnail: String
    let comics: String
    let stories: String
    let events, series: String
}
*/

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)




import Foundation

struct HeroeWelcome: Codable {
    let data: HeroeDataClass
}

struct HeroeDataClass: Codable {
    let results: [Hero]
}

struct Hero: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: HeroeThumbnail
}

struct HeroeThumbnail: Codable {
    let path: String
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}


// MARK: - URLElement
struct HeroeURLElement: Codable {
    let type, url: String
}


