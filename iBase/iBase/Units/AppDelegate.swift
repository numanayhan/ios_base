//
//  AppDelegate.swift
//  iBase
//
//  Created by Melike Büşra Ayhan on 5.07.2021.
//

import UIKit
import LanguageManager_iOS
 
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    

    var window: UIWindow?
    var appRoot : AppRoot?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
       
        
        LanguageManager.shared.defaultLanguage = .en
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .black
        window?.makeKeyAndVisible()
        appRoot = AppRoot(window: window!)
        appRoot?.login()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .black
        return true
    }

}
