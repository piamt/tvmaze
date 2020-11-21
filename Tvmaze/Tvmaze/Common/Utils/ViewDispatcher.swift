//
//  ViewDispatcher.swift
//  Tvmaze
//
//  Created by Pia on 21/11/2020.
//

import Foundation

final class ViewDispatcher {

    static var shared: ViewDispatcher = ViewDispatcher()
    var dispatcher: ViewDipatcherProtocol = DispatcherDefault()

    func execute(_ action: @escaping () -> Void) {
        dispatcher.execute(action)
    }
}

protocol ViewDipatcherProtocol: class {
    func execute(_ action: @escaping () -> Void)
}

class DispatcherDefault: ViewDipatcherProtocol {
    
    func execute(_ action: @escaping () -> Void) {
        DispatchQueue.main.async(execute: action)
    }
}

class DispatcherMock: ViewDipatcherProtocol {
    
    func execute(_ action: @escaping () -> Void) {
        action()
    }
}
