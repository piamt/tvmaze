//
//  String+Extension.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
