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
    
    var imageUrl: String? {
        entity.image?.original ?? entity.image?.medium
    }
    
    var rating: String {
        guard let myRating = entity.rating?.average else {
            return "ShowDetail.Rating.NoRatingAvailable".localized
        }
        return "ShowDetail.Rating.Title".localized + " \(myRating)"
    }
    
    var summary: String {
        entity.summary ?? ""
    }
}
