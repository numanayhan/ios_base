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
        
        menuBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil , paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 54, height: 54)
       
    }
    
 
}



struct CustomButton {
    let title:String
    let image:String
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
    func setBarButton(withText text:String,  image:String) -> UIButton{
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(text, for: .normal)
        btn.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 13)
       // btn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: -90, right: 0)
        
        return btn
    }
}
