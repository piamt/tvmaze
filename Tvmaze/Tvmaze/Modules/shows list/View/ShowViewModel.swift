//
//  ShowViewModel.swift
//  Tvmaze
//
//  Created by Pia on 21/11/2020.
//

import Foundation

struct ShowViewModel {
    let entity: ShowEntity
    
    var name: String {
        entity.name
    }
    
    var imageUrl: String {
        entity.image.medium
    }
}
