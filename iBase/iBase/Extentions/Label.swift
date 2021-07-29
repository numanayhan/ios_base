//
//  Label.swift
//  iBase
//
//  Created by Numan Ayhan on 20.07.2021.
//

import Foundation
import UIKit

class Label: UILabel {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
//    @IBInspectable var topInset: CGFloat = 5.0
//    @IBInspectable var bottomInset: CGFloat = 5.0
//        @IBInspectable var leftInset: CGFloat = 7.0
//        @IBInspectable var rightInset: CGFloat = 7.0
//
//    override func drawText(in rect: CGRect) {
//        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
//        super.drawText(in: rect.inset(by: insets))
//    }
    func commonInit(){
        self.layer.cornerRadius = self.bounds.width/2
        self.clipsToBounds = true
        self.textColor = UIColor.white
        self.setProperties(borderWidth: 1.0, borderColor:UIColor.black )
    }
    func setProperties(borderWidth: Float, borderColor: UIColor) {
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = borderColor.cgColor
    }
}

extension Label {
    
//    func outLine(_ oulineColor: UIColor,_ foregroundColor: UIColor){ 
//        let strokeTextAttributes = [
//            NSAttributedString.Key.strokeColor : oulineColor,
//            NSAttributedString.Key.foregroundColor : foregroundColor,
//            NSAttributedString.Key.strokeWidth : -4.0,
//            NSAttributedString.Key.font : font ?? UIFont.systemFontSize
//            ] as [NSAttributedString.Key : Any]
//        self.attributedText = NSMutableAttributedString(string: self.text ?? "", attributes: strokeTextAttributes)
//    }
    
    func underline() {
       if let textString = text {
            let attributedString = NSMutableAttributedString(string: textString)
   attributedString.addAttribute(   NSAttributedString.Key.underlineStyle,
             value: NSUnderlineStyle.single.rawValue,
range: NSRange(location: 0,
length: attributedString.length))
      attributedText = attributedString
        }
    }
}
