//
//  Navbar.swift
//  iBase
//
//  Created by Melike Büşra Ayhan on 12.07.2021.
//

import Foundation
import UIKit

class NavbarClear: UINavigationController {
    var hide = true {
        didSet {
            self.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationBar.backgroundColor  = UIColor.clear
            self.navigationBar.shadowImage = UIImage()
        }
    }
}
