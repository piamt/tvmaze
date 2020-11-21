//
//  ShowsListPresenterTests.swift
//  TvmazeTests
//
//  Created by Pia on 21/11/2020.
//

import XCTest
@testable import Tvmaze

private class ShowsListViewMock: ShowsListViewProtocol {
    
    enum ShowsListViewCall: Equatable {
        case none
        case reload([ShowViewModel])
        case error(String)
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case (.none, .none):
                return true
            case (.reload(let vm1), .reload(let vm2)):
                return vm1.first?.entity.id == vm2.first?.entity.id
            case (.error(let er1), .error(let er2)):
                return er1 == er2
            default:
                return false
            }
        }
    }
    
    var call: ShowsListViewCall = .none
    
    var presenter: ShowsListPresenterProtocol?
    
    func populate(_ state: ShowsListState) {
        switch state {
        case .reload(let viewModel, _):
            call = .reload(viewModel)
        case .error(let error):
            call = .error(error)
        }
    }
}

private class ShowsListInteractorMock: ShowsListInteractorInputProtocol {
    
    enum ShowsListInteractorCall {
        case none
        case reloadShows
        case requestShows
    }
    
    var call: ShowsListInteractorCall = .none
    
    var presenter: ShowsListInteractorOutputProtocol?
    var repository: ShowsListRepositoryProtocol?
    var isLastPage: Bool = false
    
    func showEntityForIndex(_ index: Int) -> ShowEntity {
        ShowEntity(id: 1, name: "Show 1", image: nil, rating: nil, summary: nil)
    }

    func `do`(_ job: ShowsListJob) {
        switch job {
        case .reloadTvShows:
            call = .reloadShows
        case .requestTvShows:
            call = .requestShows
        }
    }
}

private class ShowsListWireframeMock: ShowsListWireframeProtocol {
    
    enum ShowsListWireframePage: Equatable {
        case none
        case showDetail(ShowEntity)
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case (.none, .none):
                return true
            case (.showDetail(let entity1), showDetail(let entity2)):
                return entity1.id == entity2.id
            default:
                return false
            }
        }
    }
    
    var page: ShowsListWireframePage = .none
    
    var view: UIViewController?
    
    func navigate(to page: ShowsListPage) {
        switch page {
        case .showDetail(let entity):
            self.page = .showDetail(entity)
        }
    }
}

class ShowsListPresenterTests: XCTestCase {

    var presenter: ShowsListPresenter!
    fileprivate var view: ShowsListViewMock!
    fileprivate var interactor: ShowsListInteractorMock!
    fileprivate var wireframe: ShowsListWireframeMock!
    
    override func setUp() {
        super.setUp()
        ViewDispatcher.shared.dispatcher = DispatcherMock()
        
        presenter = ShowsListPresenter()
        view = ShowsListViewMock()
        interactor = ShowsListInteractorMock()
        wireframe = ShowsListWireframeMock()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
    }

    override func tearDown() {
        super.tearDown()
        ViewDispatcher.shared.dispatcher = DispatcherDefault()
    }

    func test_PerformReload() throws {
        presenter.perform(.reload)
        XCTAssertEqual(interactor.call, .reloadShows)
    }
    
    func test_PerformFetchData() throws {
        presenter.perform(.fetchData)
        XCTAssertEqual(interactor.call, .requestShows)
    }
    
    func test_PerformFetchDetail() throws {
        let index = Int.random(in: 0...10)
        presenter.perform(.detail(index: index))
        XCTAssertEqual(wireframe.page, .showDetail(showsArray.first!.entity))
    }
    
    func test_HandleShowsSucceed() throws {
        presenter.handle(.tvShowsSucceeded(showsArray))
        XCTAssertEqual(view.call, .reload(showsArray))
    }
    
    func test_HandleShowsFailed() throws {
        let error = ErrorModel(APIError.General.unknownException)
        presenter.handle(.tvShowsFailed(error))
        XCTAssertEqual(view.call, .error(error.value.string.localized))
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
