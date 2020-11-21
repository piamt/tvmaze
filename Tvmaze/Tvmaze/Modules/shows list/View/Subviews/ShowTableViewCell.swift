//
//  ShowTableViewCell.swift
//  Tvmaze
//
//  Created by Pia on 21/11/2020.
//

import UIKit

class ShowTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicatorView.hidesWhenStopped = true
        
        borderView.layer.borderWidth = 1.0
        borderView.layer.borderColor = UIColor.gray.cgColor
        borderView.layer.cornerRadius = 5
        borderView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setup(with: .none)
    }
    
    func setup(with show: ShowViewModel?) {
        guard let show = show else {
            indicatorView.startAnimating()
            cellImage.isHidden = true
            cellLabel.isHidden = true
            return
        }
        
        indicatorView.stopAnimating()
        cellImage.isHidden = false
        cellLabel.isHidden = false
        cellLabel.text = show.name
        populateImage(show.imageUrl, placeholder: "placeholder")
    }
    
    private func populateImage(_ imageUrl: String?, placeholder: String) {
        if let imageUrl = imageUrl {
            cellImage.sd_setImage(with: URL(string: imageUrl),
                                                placeholderImage: UIImage(named: placeholder),
                                                options: [.retryFailed]) { (_, _, _, _) in
                self.cellImage.contentMode = .scaleAspectFit
                self.setNeedsLayout()
            }
        } else {
            cellImage.image = UIImage(named: placeholder)
            cellImage.contentMode = .scaleAspectFit
        }
    }
}
