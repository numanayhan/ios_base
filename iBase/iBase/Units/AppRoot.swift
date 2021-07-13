//
//  AppRoot.swift
//  iBase
//
//  Created by Melike Büşra Ayhan on 11.07.2021.
//

import Foundation
import UIKit
public class DefaultNavigation: UINavigationController {
    var isDark = false {
        didSet {
            
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    var hide = true {
        didSet {
            self.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationBar.backgroundColor  = UIColor.clear
            self.navigationBar.shadowImage = UIImage()
        }
    }
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDark ? .lightContent : .default
    }
}
class AppRoot {
    private let window : UIWindow?
    init(window: UIWindow ) {
        self.window = window
    }
    func startApp() {
        let launch = UIStoryboard(name: "Launch", bundle: nil)
        let launchVC = launch.instantiateViewController(withIdentifier: "Launch") as? Launch
        let root = DefaultNavigation(rootViewController: launchVC!)
        root.hide = true
        window!.rootViewController = root
        window!.makeKeyAndVisible()
    }
}
