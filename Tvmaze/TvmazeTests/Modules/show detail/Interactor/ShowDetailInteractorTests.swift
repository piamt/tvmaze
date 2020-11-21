//
//  ShowDetailInteractorTests.swift
//  TvmazeTests
//
//  Created by Pia on 21/11/2020.
//

import XCTest
@testable import Tvmaze

fileprivate class ShowDetailPresenterMock: ShowDetailInteractorOutputProtocol {
    
    enum ShowDetailPresenterCall: Equatable {
        case none
        case showDetail(DetailViewModel)
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case (.none, .none):
                return true
            case (.showDetail(let vm1), .showDetail(let vm2)):
                return vm1.entity.id == vm2.entity.id
            default:
                return false
            }
        }
    }
    
    var call: ShowDetailPresenterCall = .none
    
    func handle(_ result: ShowDetailIteractorResult) {
        switch result {
        case .showDetail(let viewModel):
            call = .showDetail(viewModel)
            
        }
    }
}

class ShowDetailInteractorTests: XCTestCase {

    var interactor: ShowDetailInteractor!
    fileprivate var presenter: ShowDetailPresenterMock!
    let entity = ShowEntity(id: 251,
                            name: "Downton Abbey",
                            image: nil,
                            rating: RatingEntity(average: 9.1),
                            summary: "<p>The Downton Abbey estate stands a splendid example of confidence and mettle, its family enduring for generations and its staff a well-oiled machine of propriety. But change is afoot at Downton--change far surpassing the new electric lights and telephone. A crisis of inheritance threatens to displace the resident Crawley family, in spite of the best efforts of the noble and compassionate Earl, Robert Crawley; his American heiress wife, Cora his comically implacable, opinionated mother, Violet and his beautiful, eldest daughter, Mary, intent on charting her own course. Reluctantly, the family is forced to welcome its heir apparent, the self-made and proudly modern Matthew Crawley himself none too happy about the new arrangements. As Matthew\'s bristly relationship with Mary begins to crackle with electricity, hope for the future of Downton\'s dynasty takes shape. But when petty jealousies and ambitions grow among the family and the staff, scheming and secrets--both delicious and dangerous--threaten to derail the scramble to preserve Downton Abbey. <i>Downton Abbey</i> offers a spot-on portrait of a vanishing way of life.</p>")
    
    override func setUp() {
        super.setUp()
        interactor = ShowDetailInteractor(entity: entity)
        presenter = ShowDetailPresenterMock()
        
        interactor.presenter = presenter
    }

    func test_RequestShowDetail() throws {
        interactor.do(.requestShowDetail)
        XCTAssertEqual(presenter.call, .showDetail(DetailViewModel(entity: entity)))
    }
}
