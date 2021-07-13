//
//  AppDelegate.swift
//  iBase
//
//  Created by Melike Büşra Ayhan on 5.07.2021.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appRoot : AppRoot?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


        window = UIWindow(frame: UIScreen.main.bounds)
        appRoot = AppRoot.init(window: window!)
        appRoot?.startApp()

        return true
    }

}
