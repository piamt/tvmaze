//
//  ShowsListViewTests.swift
//  TvmazeTests
//
//  Created by Pia on 21/11/2020.
//

import XCTest
import FBSnapshotTestCase
@testable import Tvmaze

fileprivate class ShowsListPresenterMock: ShowsListPresenterProtocol {
    var view: ShowsListViewProtocol?
    var interactor: ShowsListInteractorInputProtocol?
    var wireframe: ShowsListWireframeProtocol?
    
    func perform(_ action: ShowsListViewAction) {}
}

class ShowsListViewTests: FBSnapshotTestCase {
    
    var view: ShowsListView!
    fileprivate var presenter: ShowsListPresenterMock!
    
    override func setUp() {
        super.setUp()
        UIView.setAnimationsEnabled(false)
        ViewDispatcher.shared.dispatcher = DispatcherMock()
        view = ShowsListView()
        presenter = ShowsListPresenterMock()
        view.presenter = presenter
        view.loadViewIfNeeded()
    }

    override func tearDown() {
        super.tearDown()
        UIView.setAnimationsEnabled(true)
        ViewDispatcher.shared.dispatcher = DispatcherDefault()
    }

    func test_Screenshot_PopulateReload() throws {
        view.populate(.reload(showsArray, isLastPage: false))
        FBSnapshotVerifyView(view.view)
    }
}

private var showsArray: [ShowViewModel] {
    if let data = try? JSONUtils.readJSON(filename: "ShowEntity"),
       let array = try? JSONDecoder().decode([ShowEntity].self, from: data) {
        return array.compactMap({ ShowViewModel(entity: $0) })
    } else {
        XCTFail()
        return []
    }
}
