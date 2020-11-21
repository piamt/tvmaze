//
//  ShowDetailWireframeTests.swift
//  TvmazeTests
//
//  Created by Pia on 21/11/2020.
//

import XCTest
@testable import Tvmaze

class ShowDetailWireframeTests: XCTestCase {
    
    var wireframe: ShowDetailWireframe!
    var view: ShowDetailView!

    override func setUp() {
        super.setUp()
        wireframe = ShowDetailWireframe()
        view = ShowDetailWireframe.createModule(entity: ShowEntity(id: 1, name: "Show 1", image: nil, rating: nil, summary: nil)) as? ShowDetailView
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
    
    func test_CreateModule_InteractorPresenter() throws {
        XCTAssertNotNil(view.presenter?.interactor?.presenter)
    }
    
    func test_CreateModule_PresenterWireframe() throws {
        XCTAssertNotNil(view.presenter?.wireframe)
    }
    
    func test_CreateModule_WireframeView() throws {
        XCTAssertNotNil(view.presenter?.wireframe?.view)
    }
}
