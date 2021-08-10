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
    @IBInspectable var titleBar = UILabel()
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
            .font: UIFont.boldSystemFont(ofSize: 11)
        ]
        let attributeString = NSMutableAttributedString(string: "", attributes: lineattribute)
        setAttributedTitle(attributeString, for: .normal)
        contentEdgeInsets  = UIEdgeInsets.init(top: 0, left: 0, bottom: -135, right: 0)
        titleBar.adjustsFontSizeToFitWidth = true
        titleBar.attributedText = attributeString
         
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
         
        print("title : ",titleLabel?.attributedText?.string ,"active:",active)
        if active {
            setSelected()
        } else {
            setDeselected()
        }
        self.addTarget(self, action: #selector(onPress), for: .touchUpInside)
        
        setDeselected()
        
        
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
        setImage(bgImageSelected)
        titleLabel?.textColor = UIColor.white
    }
    
    // Set the deselcted properties
    func setDeselected() {
        titleLabel?.textColor = UIColor.init(named: "#C0BCE3")
        backgroundColor = UIColor.hex("EDEEF2")
        border.strokeColor = borderColorDeselected.cgColor
        setImage(bgImageDeSelected)
    }
    func setImage(_ image : UIImage){
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop:
                            0, paddingLeft:  0, paddingBottom: 0, paddingRight: 0, width: 54, height:54)
        
    }
}

