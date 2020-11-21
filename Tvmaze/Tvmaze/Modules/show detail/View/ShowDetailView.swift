//
//  ShowDetailView.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import UIKit
import SDWebImage

class ShowDetailView: UIViewController, ShowDetailViewProtocol {
    var presenter: ShowDetailPresenterProtocol?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.perform(.load)
    }
    
    func populate(_ state: ShowDetailState) {
        switch state {
        case .load(let viewModel):
            populateDetail(viewModel)
        }
    }
    
    private func populateDetail(_ viewModel: DetailViewModel) {
        title = viewModel.name
        ratingLabel.text = viewModel.rating
        populateImage(viewModel.imageUrl, placeholder: "placeholder")
        populateSummary(viewModel.summary)
    }
    
    private func populateSummary(_ summary: String) {
        summaryLabel.attributedText = summary.convertToAttributedString()
    }
    
    private func populateImage(_ imageUrl: String?, placeholder: String) {
        if let imageUrl = imageUrl {
            imageView.sd_setImage(with: URL(string: imageUrl),
                                                placeholderImage: UIImage(named: placeholder),
                                                options: [.retryFailed]) { (_, _, _, _) in
                self.imageView.contentMode = .scaleAspectFit
                self.view.setNeedsLayout()
            }
        } else {
            imageView.image = UIImage(named: placeholder)
            imageView.contentMode = .scaleAspectFit
        }
    }
}
