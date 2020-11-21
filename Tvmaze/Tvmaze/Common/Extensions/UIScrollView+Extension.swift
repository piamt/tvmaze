//
//  UIScrollView+Extension.swift
//  Tvmaze
//
//  Created by Pia on 21/11/2020.
//

import UIKit

extension UIScrollView {
    func scrollsToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        setContentOffset(bottomOffset, animated: true)
    }
}
