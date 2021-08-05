//
//  Colors.swift
//  iBase
//
//  Created by Melike Büşra Ayhan on 7.07.2021.
//

import Foundation
import UIKit


struct Colors{
    
    static let background  = UIColor.hex(hex: "#FFFFFF")
    static let pink  = UIColor.hex(hex: "#FF0076")
    static let navbarText = UIColor.hex(hex: "#262832")
    static let navbarLine = UIColor.hex(hex: "#E1E2E3")
    static let tabMenu = UIColor.hex(hex: "#6D5EF7")
} 

extension UIColor {
    
    static func hex(_ hex:String) -> UIColor {
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
