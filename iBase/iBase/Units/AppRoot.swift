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
    func example(){
        let root = DefaultNavigation(rootViewController: Examples())
        root.hide = true
        window!.rootViewController = root
        window!.makeKeyAndVisible()
    }
    func langList(){
        let root = DefaultNavigation(rootViewController: LangList())
        root.hide = true
        window!.rootViewController = root
        window!.makeKeyAndVisible()
    }
    func topMenu(){
        let root = DefaultNavigation(rootViewController: TopMenu())
        root.hide = true
        window!.rootViewController = root
        window?.backgroundColor = .black
        window!.makeKeyAndVisible() 
        UINavigationBar.appearance().isTranslucent = false
         
    }
    func stretchy(){
         
        window!.rootViewController = StretchyHeader(collectionViewLayout: StretchyHeaderLayout())
        window!.makeKeyAndVisible()
        
         
    }
    func login(){
         
        window!.rootViewController = Login()
        window!.makeKeyAndVisible()
        
         
    }
    func list(){
         
        let root = DefaultNavigation(rootViewController: Collection())
        root.hide = true
        window!.rootViewController = root
        window?.backgroundColor = .black
        window!.makeKeyAndVisible()
        UINavigationBar.appearance().isTranslucent = false
    }
    func menuTop(){
        let root = DefaultNavigation(rootViewController: MenuTop())
        root.hide = true
        window!.rootViewController = root
        window?.backgroundColor = .black
        window!.makeKeyAndVisible()
        
        UINavigationBar.appearance().isTranslucent = false
    }
    func slide(){
        let root = DefaultNavigation(rootViewController: SlideCollection())
        root.hide = true
        window!.rootViewController = root
        window?.backgroundColor = .black
        window!.makeKeyAndVisible()
        
        UINavigationBar.appearance().isTranslucent = false
    }
}
