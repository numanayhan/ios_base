//
//  MenuButton.swift
//  iBase
//
//  Created by Numan Ayhan on 4.08.2021.
//

import Foundation
import UIKit

@IBDesignable class MenuButton: UIButton {
    @IBInspectable var borderColorSelected:UIColor = UIColor.hex("#6767D9")
    @IBInspectable var borderColorDeselected:UIColor = UIColor.white
    @IBInspectable var borderWidth:CGFloat = 2
    @IBInspectable var cornerRadius:CGFloat = 45
    @IBInspectable var bgImageSelected:UIImage = UIImage()
        @IBInspectable var bgImageDeSelected:UIImage = UIImage()
    // Sets the Active/Inactive State
    @IBInspectable var active:Bool = false
    // Custom Border to the UIButton
       private let border = CAShapeLayer()
       
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func draw(_ rect: CGRect) {
        
        backgroundColor = UIColor.hex("EDEEF2")
        cornerRadius = 45
        layer.cornerRadius = cornerRadius
        let lineattribute : [NSAttributedString.Key : Any] = [
            .foregroundColor : UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        let attributeString = NSMutableAttributedString(string: "Ana Sayfa", attributes: lineattribute)
        
        setAttributedTitle(attributeString, for: .normal)
        contentEdgeInsets  = UIEdgeInsets.init(top: 0, left: 0, bottom: -135, right: 0)
        
        //Border
        
        // Setup CAShape Layer (Dashed/Solid Border)
        border.lineWidth = borderWidth
        border.frame = self.bounds
        border.fillColor = backgroundColor?.cgColor
        border.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        self.layer.addSublayer(border)
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        
       
        updateLayerProperties()
        
        // Setup the Button Depending on What State it is in
                if active {
                    setSelected()
                } else {
                    setDeselected()
                }
        imageRect(forContentRect: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        imageView?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        currentBackgroundImage?.resizableImage(withCapInsets: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0), resizingMode: UIImage.ResizingMode.tile)
        // Respond to touch events by user
             self.addTarget(self, action: #selector(onPress), for: .touchUpInside)
    }
    override func imageRect(forContentRect contentRect:CGRect) -> CGRect {
        var imageFrame = super.imageRect(forContentRect: contentRect)
        imageFrame.origin.x = super.titleRect(forContentRect: contentRect).maxX - imageFrame.width
            return imageFrame
    }
    func updateLayerProperties() {
            self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 3)
            self.layer.shadowOpacity = 1.0
            self.layer.shadowRadius = 10.0
           
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func onPress() {
            print("Button Pressed")
            active = !active
            if active {
                setSelected()
            } else {
                setDeselected()
            }
        }
    // Set the selected properties
        func setSelected() {
            backgroundColor = UIColor.hex("EDEEF2")
            border.strokeColor = borderColorSelected.cgColor
            setBackgroundImage(bgImageSelected, for: .normal)

        }
        
        // Set the deselcted properties
        func setDeselected() {
            
            backgroundColor = UIColor.hex("EDEEF2")
            border.strokeColor = borderColorDeselected.cgColor
            setBackgroundImage(bgImageDeSelected, for: .normal)
            
        }
}

