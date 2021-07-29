//
//  SlideMenu.swift
//  iBase
//
//  Created by Numan Ayhan on 27.07.2021.
//

import UIKit
import Foundation
class SlideMenu: UIViewController {

    let menuBar = MenuBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

         setLayout()
    }
    func setLayout(){
        
        view.backgroundColor = Colors.tabMenu
        
        if navigationController != nil {
            view.backgroundColor = .white
            navigationController?.navigationBar.backgroundColor   =  .white
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationController?.navigationBar.isHidden = false
            
        }
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menuBar)
//        NSLayoutConstraint.activate([
//            menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            menuBar.heightAnchor.constraint(equalToConstant: 42)
//        ])
//
        
        menuBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil , paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 54, height: 54)
       
    }
    
 
}

class MenuBar : UIView {
    var firstBtn : MenuButton!
    var secondBtn:MenuButton!
    var thirteenBtn:MenuButton!
    
    var buttons : [MenuButton]!
    override init(frame: CGRect) {
      
        
        firstBtn  = setBarButton(withText: "Anasayfa",image: "home")
        secondBtn  = setBarButton(withText: "Çapraz Satış", image: "home")
        thirteenBtn  = setBarButton(withText: "Aktiviteler",image: "home")
        
        buttons = [firstBtn,secondBtn,thirteenBtn]
        
        super.init(frame: .zero)
        
        firstBtn.addTarget(self , action: #selector(firstTap), for: .primaryActionTriggered)
        
        setLayout()
    }
    required init?(coder:NSCoder) {
        fatalError("initt error")
    }
    private func setLayout(){
        
        addSubview(firstBtn)
        addSubview(secondBtn)
        addSubview(thirteenBtn)
         
        firstBtn.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil , paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 80, height: 135)
        secondBtn.anchor(top: topAnchor, left: firstBtn.rightAnchor, bottom: nil, right: nil , paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 80, height: 135)
        thirteenBtn.anchor(top: topAnchor, left: secondBtn.rightAnchor, bottom: nil, right: nil , paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 80, height: 135)
        
        
    }
}
extension MenuBar{
   
    @objc func firstTap(){
        //delegate?.didSelected(index:0)
    }
    @objc func secondTap(){
        //delegate?.didSelected(index:1)
    }
    @objc func thirteenTap(){
        //delegate?.didSelected(index:2)
    }
    
}
func setBarButton(withText text:String,  image:String) -> MenuButton{
    let btn = MenuButton(with: .init(title: text, image: image))
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.setTitle(text, for: .normal)
    btn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 13)
    btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: -90, right: 0)
    
    return btn
}

struct CustomButton {
    let title:String
    let image:String
}
class MenuButton :UIButton {
    private let mTitle:UILabel = {
       let label = UILabel()
        return label
    }()
    private let mImage: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage.init(named: "menu_button")
    return iv
    }()
    let model : CustomButton
    init(with model:CustomButton) {
        self.model = model
        super.init(frame: .zero)
        
        addSubview(mImage)
        mImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 25 , paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 54, height: 54)
        
        addSubview(mTitle)
        mTitle.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width, height: 18)
        backgroundColor = .lightGray
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(with model:CustomButton){
        mTitle.text = model.title
        mImage.image =  UIImage.init(named: model.image)
    }
     
    
}
extension UIButton {
    
    func centerVertically(padding: CGFloat = 6.0) {
        guard
            let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
            return
        }
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageViewSize.height),
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )
        
        self.contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: titleLabelSize.height,
            right: 0.0
        )
    }
    
}
