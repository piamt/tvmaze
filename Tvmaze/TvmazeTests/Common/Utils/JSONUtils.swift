//
//  JSONUtils.swift
//  TvmazeTests
//
//  Created by Pia on 21/11/2020.
//

import Foundation
@testable import Tvmaze

class JSONUtils {
    class func readJSON(filename: String) throws -> Data {
        guard let path = Bundle(for: self).path(forResource: filename, ofType: "json") else {
            throw ErrorModel(APIError.General.unknownException)
        }
        return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
}
