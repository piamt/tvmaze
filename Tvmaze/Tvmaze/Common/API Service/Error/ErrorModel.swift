//
//  ErrorModel.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

protocol APIErrorProtocol {
    var string: String { get }
}

extension APIErrorProtocol {
    func isEqual(_ lhs: APIErrorProtocol) -> Bool {
        return type(of: lhs) == type(of: self) && lhs.string == self.string
    }
}

extension APIErrorProtocol where Self: RawRepresentable, Self.RawValue == String {
    var string: String {
        return self.rawValue
    }
}

struct ErrorModel: Error, Equatable {
    let value: APIErrorProtocol

    init(_ value: APIErrorProtocol) {
        self.value = value
    }

    static func == (_ lhs: ErrorModel, _ rhs: ErrorModel) -> Bool {
        return lhs.value.isEqual(rhs.value)
    }
}
