//
//  UIViewController+Extension.swift
//  Tvmaze
//
//  Created by Pia on 21/11/2020.
//

import UIKit

extension UIViewController {
    func showError(_ error: String) {
        ViewDispatcher.shared.execute {
            let alert = UIAlertController(title: nil, message: error, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Alert.Button.Ok".localized, style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
