//
//  ShowsListWireframeTests.swift
//  TvmazeTests
//
//  Created by Pia on 21/11/2020.
//

import XCTest
@testable import Tvmaze

class ShowsListWireframeTests: XCTestCase {
    
    var wireframe: ShowsListWireframe!
    var view: ShowsListView!

    override func setUp() {
        super.setUp()
        wireframe = ShowsListWireframe()
        let navigation = ShowsListWireframe.createModule() as? UINavigationController
        view = navigation?.children.last as? ShowsListView
        
        ViewDispatcher.shared.dispatcher = DispatcherMock()
    }
    
    override func tearDown() {
        super.tearDown()
        wireframe = nil
        ViewDispatcher.shared.dispatcher = DispatcherDefault()
    }

    func test_CreateModule_View() throws {
        XCTAssertNotNil(view)
    }
    
    func test_CreateModule_Presenter() throws {
        XCTAssertNotNil(view.presenter)
    }
    
    func test_CreateModule_PresenterView() throws {
        XCTAssertNotNil(view.presenter?.view)
    }
    
    func test_CreateModule_PresenterInteractor() throws {
        XCTAssertNotNil(view.presenter?.interactor)
    }
    
    func test_CreateModule_PresenterWireframe() throws {
        XCTAssertNotNil(view.presenter?.wireframe)
    }
    
    func test_CreateModule_WireframeView() throws {
        XCTAssertNotNil(view.presenter?.wireframe?.view)
    }
    
    func test_CreateModule_InteractorRepository() throws {
        XCTAssertNotNil(view.presenter?.interactor?.repository)
    }
    
    func test_CreateModule_InteractorPresenter() throws {
        XCTAssertNotNil(view.presenter?.interactor?.presenter)
    }
}
