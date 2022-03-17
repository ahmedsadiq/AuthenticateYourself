//
//  UITextfield+Additions.swift
//  2FA
//
//  Created by Ahmed Sadiq on 15/03/2022.
//

import Foundation
import UIKit

extension UITextField {
    func placeholderColor(_ color: UIColor) {
        var placeholderText = ""
        if self.placeholder != nil {
            placeholderText = self.placeholder!
        }
        self.attributedPlaceholder = NSAttributedString(
            string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}
