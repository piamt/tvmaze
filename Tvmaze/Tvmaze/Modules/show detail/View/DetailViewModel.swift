//
//  DetailViewModel.swift
//  Tvmaze
//
//  Created by Pia on 21/11/2020.
//

import Foundation

struct DetailViewModel {
    let entity: ShowEntity
    
    var name: String {
        entity.name
    }
    
    var imageUrl: String {
        entity.image.original ?? entity.image.medium
    }
    
    var rating: Double? {
        entity.rating.average
    }
    
    var summary: String {
        entity.summary
    }
}
