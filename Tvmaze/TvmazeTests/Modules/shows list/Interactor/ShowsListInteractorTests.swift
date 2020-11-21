//
//  ShowsListInteractorTests.swift
//  TvmazeTests
//
//  Created by Pia on 21/11/2020.
//

import XCTest
@testable import Tvmaze

fileprivate class ShowsListPresenterMock: ShowsListInteractorOutputProtocol {
    
    enum ShowsListPresenterCall: Equatable {
        case none
        case showsSucceed([ShowViewModel])
        case showsFailed(ErrorModel)
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case (.none, .none):
                return true
            case (.showsSucceed(let array1), .showsSucceed(let array2)):
                return array1.first?.entity.id == array2.first?.entity.id
            case (.showsFailed(let error1), .showsFailed(let error2)):
                return error1.value.string == error2.value.string
            default:
                return false
            }
        }
    }
    
    var call: ShowsListPresenterCall = .none
    
    func handle(_ result: ShowsListIteractorResult) {
        switch result {
        case .tvShowsSucceeded(let array):
            call = .showsSucceed(array)
        case .tvShowsFailed(let errorModel):
            call = .showsFailed(errorModel)
        }
    }
}

private class ShowsListRepositoryMock: ShowsListRepositoryProtocol {
    enum ShowsListRepositoryRequest {
        case none
        case tvShows
    }

    enum ShowsListRepositoryResult {
        case none
        case error
        case success
        case successFinished
    }
    
    var request: ShowsListRepositoryRequest = .none
    var result: ShowsListRepositoryResult = .none
    
    func tvShows(page: Int, resultBlock: @escaping ShowsListResultBlock) {
        request = .tvShows
        switch result {
        case .error:
            resultBlock(.failure(ErrorModel(APIError.General.parsing)))
        case .success:
            resultBlock(.success(showsArray))
        case .successFinished:
            resultBlock(.success([]))
        default:
            break
        }
    }
}

class ShowsListInteractorTests: XCTestCase {
    
    var interactor: ShowsListInteractor!
    fileprivate var presenter: ShowsListPresenterMock!
    fileprivate var repository: ShowsListRepositoryMock!
    
    override func setUp() {
        super.setUp()
        interactor = ShowsListInteractor()
        presenter = ShowsListPresenterMock()
        repository = ShowsListRepositoryMock()
        
        interactor.presenter = presenter
        interactor.repository = repository
    }

    func test_IsLastPage_When_ReloadTvShows() throws {
        interactor.do(.reloadTvShows)
        XCTAssertFalse(interactor.isLastPage)
    }
    
    func test_ReloadTvShows_error() throws {
        repository.result = .error
        interactor.do(.reloadTvShows)
        XCTAssertEqual(repository.request, .tvShows)
    }
    
    func test_ReloadTvShows_error_showsFailed() throws {
        repository.result = .error
        interactor.do(.reloadTvShows)
        XCTAssertEqual(presenter.call, .showsFailed(ErrorModel(APIError.General.parsing)))
    }
    
    func test_ReloadTvShows_success() throws {
        repository.result = .success
        interactor.do(.reloadTvShows)
        XCTAssertEqual(repository.request, .tvShows)
    }
    
    func test_ReloadTvShows_success_ShowsSucceed() throws {
        repository.result = .success
        interactor.do(.reloadTvShows)
        XCTAssertEqual(presenter.call, .showsSucceed(showsArray.compactMap({ShowViewModel(entity: $0)})))
    }
    
    func test_RequestTvShows_error() throws {
        repository.result = .error
        interactor.do(.requestTvShows)
        XCTAssertEqual(repository.request, .tvShows)
    }
    
    func test_RequestTvShows_error_showsFailed() throws {
        repository.result = .error
        interactor.do(.requestTvShows)
        XCTAssertEqual(presenter.call, .showsFailed(ErrorModel(APIError.General.parsing)))
    }
    
    func test_RequestTvShows_success() throws {
        repository.result = .success
        interactor.do(.requestTvShows)
        XCTAssertEqual(repository.request, .tvShows)
    }
    
    func test_RequestTvShows_success_ShowsSucceed() throws {
        repository.result = .success
        interactor.do(.requestTvShows)
        XCTAssertEqual(presenter.call, .showsSucceed(showsArray.compactMap({ShowViewModel(entity: $0)})))
    }
    
    func test_RequestTvShows_successFinished_isLastPage() throws {
        repository.result = .successFinished
        interactor.do(.requestTvShows)
        XCTAssertTrue(interactor.isLastPage)
    }
    
    func test_ShowEntityForIndex() throws {
        repository.result = .success
        interactor.do(.requestTvShows)
        
        let index = Int.random(in: 0...5)
        XCTAssertEqual(showsArray[index].id, interactor.showEntityForIndex(index).id)
    }
}

private var showsArray: [ShowEntity] {
    if let data = try? JSONUtils.readJSON(filename: "ShowEntity"),
       let array = try? JSONDecoder().decode([ShowEntity].self, from: data) {
        return array
    } else {
        XCTFail()
        return []
    }
}
