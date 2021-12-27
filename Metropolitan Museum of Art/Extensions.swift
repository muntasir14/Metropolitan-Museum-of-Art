//
//  Extensions.swift
//  Metropolitan Museum of Art
//
//  Created by Mobile Apps Team on 27/12/21.
//

import Foundation
import UIKit


extension UIViewController {
    
    func showAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionController = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.dismiss(animated: true)
        })
        
        alertController.addAction(actionController)
        present(alertController, animated: true)
    }

}

