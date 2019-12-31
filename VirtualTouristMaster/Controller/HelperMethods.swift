//
//  HelperMethods.swift
//  VirtualTouristMaster
//
//  Created by Ahmad on 21/12/2019.
//  Copyright © 2019 Ahmad. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    
    // Mark: -- Alert Method
    /***************************************************************/
    
    func raiseAlertView(withTitle: String, withMessage: String) {
        
        let alertController = UIAlertController(title: withTitle, message: withMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}
