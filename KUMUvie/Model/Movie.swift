//
//  Movie.swift
//  KUMUvie
//
//  Created by Jerk Nino Magdadaro on 10/25/21.
//

import Foundation

struct Response: Codable {
    let results: [MovieModel]
}

struct MovieModel: Codable {
    let trackId: Int
    let trackName: String
    let artworkUrl100: String
    let primaryGenreName: String
    let trackPrice: Float
    let longDescription: String
}
