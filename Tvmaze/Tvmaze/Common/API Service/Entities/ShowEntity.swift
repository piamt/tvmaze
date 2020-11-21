//
//  ShowEntity.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

struct RatingEntity: Codable {
    var average: Double?
}

struct ImageEntity: Codable {
    var original: String?
    var medium: String?
}

struct ShowEntity: Codable {
    var name: String
    var image: ImageEntity?
    var rating: RatingEntity?
    var summary: String
}
