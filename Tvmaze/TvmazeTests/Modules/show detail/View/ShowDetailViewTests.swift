//
//  ShowDetailViewTests.swift
//  TvmazeTests
//
//  Created by Pia on 21/11/2020.
//

import XCTest
import FBSnapshotTestCase
@testable import Tvmaze

fileprivate class ShowDetailPresenterMock: ShowDetailPresenterProtocol {
    var view: ShowDetailViewProtocol?
    var interactor: ShowDetailInteractorInputProtocol?
    var wireframe: ShowDetailWireframeProtocol?
    
    func perform(_ action: ShowDetailViewAction) {}
}

class ShowDetailViewTests: FBSnapshotTestCase {
    
    var view: ShowDetailView!
    fileprivate var presenter: ShowDetailPresenterMock!
    
    let entity = ShowEntity(id: 251,
                            name: "Downton Abbey",
                            image: nil,
                            rating: RatingEntity(average: 9.1),
                            summary: "<p>The Downton Abbey estate stands a splendid example of confidence and mettle, its family enduring for generations and its staff a well-oiled machine of propriety. But change is afoot at Downton--change far surpassing the new electric lights and telephone. A crisis of inheritance threatens to displace the resident Crawley family, in spite of the best efforts of the noble and compassionate Earl, Robert Crawley; his American heiress wife, Cora his comically implacable, opinionated mother, Violet and his beautiful, eldest daughter, Mary, intent on charting her own course. Reluctantly, the family is forced to welcome its heir apparent, the self-made and proudly modern Matthew Crawley himself none too happy about the new arrangements. As Matthew\'s bristly relationship with Mary begins to crackle with electricity, hope for the future of Downton\'s dynasty takes shape. But when petty jealousies and ambitions grow among the family and the staff, scheming and secrets--both delicious and dangerous--threaten to derail the scramble to preserve Downton Abbey. <i>Downton Abbey</i> offers a spot-on portrait of a vanishing way of life.</p>")
    
    override func setUp() {
        super.setUp()
        UIView.setAnimationsEnabled(false)
        ViewDispatcher.shared.dispatcher = DispatcherMock()
        view = ShowDetailView()
        presenter = ShowDetailPresenterMock()
        view.presenter = presenter
        view.loadViewIfNeeded()
    }

    override func tearDown() {
        super.tearDown()
        UIView.setAnimationsEnabled(true)
        ViewDispatcher.shared.dispatcher = DispatcherDefault()
    }

    func test_Screenshot_PopulateLoadDetail() throws {
        view.populate(.load(DetailViewModel(entity: entity)))
        FBSnapshotVerifyView(view.view)
    }
    
    func test_Screenshot_PopulateLoadDetail_scrollToBottom() throws {
        view.populate(.load(DetailViewModel(entity: entity)))
        view.view.layoutIfNeeded()
        view.scrollView.scrollsToBottom()
        FBSnapshotVerifyView(view.view)
    }
}
