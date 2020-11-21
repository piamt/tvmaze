//
//  ShowDetailPresenterTests.swift
//  TvmazeTests
//
//  Created by Pia on 21/11/2020.
//

import XCTest
@testable import Tvmaze

private class ShowDetailViewMock: ShowDetailViewProtocol {
    
    enum ShowDetailViewCall: Equatable {
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
    
    var call: ShowDetailViewCall = .none
    
    var presenter: ShowDetailPresenterProtocol?
    
    func populate(_ state: ShowDetailState) {
        switch state {
        case .load(let viewModel):
            call = .showDetail(viewModel)
        }
    }
}

private class ShowDetailInteractorMock: ShowDetailInteractorInputProtocol {
    
    enum ShowDetailInteractorCall: Equatable {
        case none
        case requestShowDetail
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case (.none, .none), (.requestShowDetail, .requestShowDetail):
                return true
            default:
                return false
            }
        }
    }
    
    var call: ShowDetailInteractorCall = .none
    
    var presenter: ShowDetailInteractorOutputProtocol?
    
    func `do`(_ job: ShowDetailJob) {
        switch job {
        case .requestShowDetail:
            call = .requestShowDetail
        }
    }
}

private class ShowDetailWireframeMock: ShowDetailWireframeProtocol {
    var view: UIViewController?
}

class ShowDetailPresenterTests: XCTestCase {

    var presenter: ShowDetailPresenter!
    fileprivate var view: ShowDetailViewMock!
    fileprivate var interactor: ShowDetailInteractorMock!
    fileprivate var wireframe: ShowDetailWireframeMock!
    
    let entity = ShowEntity(id: 251,
                            name: "Downton Abbey",
                            image: nil,
                            rating: RatingEntity(average: 9.1),
                            summary: "<p>The Downton Abbey estate stands a splendid example of confidence and mettle, its family enduring for generations and its staff a well-oiled machine of propriety. But change is afoot at Downton--change far surpassing the new electric lights and telephone. A crisis of inheritance threatens to displace the resident Crawley family, in spite of the best efforts of the noble and compassionate Earl, Robert Crawley; his American heiress wife, Cora his comically implacable, opinionated mother, Violet and his beautiful, eldest daughter, Mary, intent on charting her own course. Reluctantly, the family is forced to welcome its heir apparent, the self-made and proudly modern Matthew Crawley himself none too happy about the new arrangements. As Matthew\'s bristly relationship with Mary begins to crackle with electricity, hope for the future of Downton\'s dynasty takes shape. But when petty jealousies and ambitions grow among the family and the staff, scheming and secrets--both delicious and dangerous--threaten to derail the scramble to preserve Downton Abbey. <i>Downton Abbey</i> offers a spot-on portrait of a vanishing way of life.</p>")
    
    override func setUp() {
        super.setUp()
        ViewDispatcher.shared.dispatcher = DispatcherMock()
        
        presenter = ShowDetailPresenter()
        view = ShowDetailViewMock()
        interactor = ShowDetailInteractorMock()
        wireframe = ShowDetailWireframeMock()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
    }

    override func tearDown() {
        super.tearDown()
        ViewDispatcher.shared.dispatcher = DispatcherDefault()
    }

    func test_PerformLoad() throws {
        presenter.perform(.load)
        XCTAssertEqual(interactor.call, .requestShowDetail)
    }
    
    func test_HandleShowDetail() throws {
        presenter.handle(.showDetail(DetailViewModel(entity: entity)))
        XCTAssertEqual(view.call, .showDetail(DetailViewModel(entity: entity)))
    }
}
