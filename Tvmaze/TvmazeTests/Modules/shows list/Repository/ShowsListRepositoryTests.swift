//
//  ShowsListRepositoryTests.swift
//  TvmazeTests
//
//  Created by Pia on 21/11/2020.
//

import XCTest
@testable import Tvmaze

class ShowsListAPIDataManagerMock: ShowsListAPIDataManagerProtocol {
    
    enum ShowsListAPIDataManagerCall {
        case none
        case tvShows
    }
    
    enum ShowsListAPIDataManagerResult {
        case none
        case success
        case error
    }
    
    var call: ShowsListAPIDataManagerCall = .none
    var result: ShowsListAPIDataManagerResult = .none
    
    func tvShows(page: Int, resultBlock: @escaping APIServiceResultBlock) {
        call = .tvShows
        switch result {
        case .success:
            resultBlock(.success(try! JSONUtils.readJSON(filename: "ShowEntity")))
        case .error:
            resultBlock(.failure(ErrorModel(APIError.General.parsing)))
        default:
            break
        }
    }
}

class ShowsListLocalDataManagerMock: ShowsListLocalDataManagerProtocol {}

class ShowsListRepositoryTests: XCTestCase {
    
    var repository: ShowsListRepository!
    fileprivate var apiDataManager: ShowsListAPIDataManagerMock!
    fileprivate var localDataManager: ShowsListLocalDataManagerMock!
    
    override func setUp() {
        super.setUp()
        apiDataManager = ShowsListAPIDataManagerMock()
        localDataManager = ShowsListLocalDataManagerMock()
        repository = ShowsListRepository(apiDataManager: apiDataManager, localDataManager: localDataManager)
    }

    func test_requestTVShows_Call() throws {
        repository.tvShows(page: 1) { _ in }
        XCTAssertEqual(apiDataManager.call, .tvShows)
    }

    func test_requestTVShows_Failure() throws {
        apiDataManager.result = .error
        repository.tvShows(page: 1) { (result) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, ErrorModel(APIError.General.parsing))
            }
        }
    }
    
    func test_requestTVShows_Success() throws {
        apiDataManager.result = .success
        repository.tvShows(page: 1) { (result) in
            switch result {
            case .success(let array):
                XCTAssertEqual(array.first!.id, showsArray.first!.id)
            case .failure:
                XCTFail()
            }
        }
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
