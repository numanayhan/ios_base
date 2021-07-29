//
//  Theme.swift
//  iBase
//
//  Created by Numan Ayhan on 26.07.2021.
//

import Foundation
import UIKit
struct Theme  {
    
    static let background = UIColor.hex(hex: "#EFF2F7")
    
}

//struct Light {
//    let main:UIColor = UIColor(hex:"#000000")
//}
//struct Dirgh {
//    let main:UIColor = UIColor(hex:"#ffffff")
//}

extension UIColor  {
    static func hex(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
//

