//
//  ShowsListViewTests.swift
//  TvmazeTests
//
//  Created by Pia on 21/11/2020.
//

import XCTest
import FBSnapshotTestCase
@testable import Tvmaze

class ShowsListViewTests: FBSnapshotTestCase {
    
    let view = ShowsListView()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        recordMode = true
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPopulateReload() throws {
        view.loadView()
        view.populate(.reload(showsArray, isLastPage: true))
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


