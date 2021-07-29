//
//  Localization.swift
//  iBase
//
//  Created by Numan Ayhan on 26.07.2021.
//

import Foundation
import UIKit
class Localization:NSObject {
    
    var bundle: Bundle!
    
    class var sharedInstance: Localization {
        struct Singleton {
            static let instance: Localization = Localization()
        }
        return Singleton.instance
    }
    
    override init() {
        super.init()
        bundle = Bundle.main
    }
    
    func localizedStringForKey(key:String, comment:String) -> String {
        return bundle.localizedString(forKey: key, value: comment, table: nil)
    }
    
    func localizedImagePathForImg(imagename:String, type:String) -> String {
        guard let imagePath =  bundle.path(forResource: imagename, ofType: type) else {
            return ""
        }
        return imagePath
    }
    func setLanguage(languageCode:String) {
        if UserDefaults.standard.object(forKey: "AppleLanguages") != nil{
            var appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                   appleLanguages.remove(at: 0)
                   appleLanguages.insert(languageCode, at: 0)
                   UserDefaults.standard.set(appleLanguages, forKey: "AppleLanguages")
                   UserDefaults.standard.synchronize() //needs restrat
                   
                   if let languageDirectoryPath = Bundle.main.path(forResource: languageCode, ofType: "lproj")  {
                       bundle = Bundle.init(path: languageDirectoryPath)
                   } else {
                       resetLocalization()
                   }
        }
       
    }
    
    //MARK:- resetLocalization
    //Resets the localization system, so it uses the OS default language.
    func resetLocalization() {
        bundle = Bundle.main
    }
    
    //MARK:- getLanguage
    // Just gets the current setted up language.
    func getLanguage() -> String {
        if  UserDefaults.standard.object(forKey: "AppleLanguages") != nil  {
            let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
                   let prefferedLanguage = appleLanguages[0]
                   if prefferedLanguage.contains("-") {
                       let array = prefferedLanguage.components(separatedBy: "-")
                       return array[0]
                   }
                   return prefferedLanguage
        }else{
            UserDefaults.standard.set("en", forKey: "Lang")
        }
        
       return ""
    }
    
}
