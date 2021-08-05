//
//  CollectionViewCell.swift
//  iBase
//
//  Created by Numan Ayhan on 2.08.2021.
//
import SDWebImagePDFCoder
import UIKit
class CollectionViewCell: UICollectionViewCell {
    var view : UIView!
    var imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(named: "noCheck")
        return iv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    var nibName: String {
        return String(describing: type(of: self))
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func loadViewFromNib() {
        imageView.image = UIImage(named: "noCheck")
        addSubview(self.imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil , right: nil, paddingTop: ( frame.height / 2)  -  30, paddingLeft:10, paddingBottom: 0, paddingRight: 0, width: 36, height: 36)
       
        imageView.addButtom()
        
    }
    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                imageView.image = UIImage(named: "check")
                imageView.shadowIcon(true)
            }
            else {
                imageView.image = UIImage(named: "noCheck")
                imageView.addButtom()
            }
        }
    }
}
extension UIImageView {
    func shadowIcon(_ check:Bool ){
        var shadowColor = UIColor.hex("#000000").cgColor
        if check {
            shadowColor = UIColor.hex("#A3FFC7").cgColor
            self.layer.shadowOpacity = 1
        }else {
            shadowColor = UIColor.hex("#000000").cgColor
            self.layer.shadowOpacity = 1
        }
        self.layer.shadowColor = shadowColor
//        self.layer.shadowOffset = .zero
//
//        self.layer.shadowRadius = frame.width / 2
//        self.clipsToBounds = false
        
        
        let shadowSize: CGFloat = 20
        let contactRect = CGRect(x: -shadowSize, y: frame.height - (shadowSize * 0.4), width: frame.width + shadowSize * 2, height: shadowSize)
        
        layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.4
        
        
    }
    func addButtom(){
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shadowRadius = 5
        layer.shadowOffset = .zero
        layer.shadowOpacity = 1
        
        
    }
    
}
