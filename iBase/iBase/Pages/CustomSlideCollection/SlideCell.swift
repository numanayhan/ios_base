//
//  SlideCell.swift
//  iBase
//
//  Created by Numan Ayhan on 6.08.2021.
//

import UIKit

class SlideCell: UICollectionViewCell {
    
      
      var data: SlideData? {
           didSet {
                guard let data = data else { return }
                menuItem.setTitle(data.title, for: .normal)
                menuItem.bgImageSelected = data.select
                menuItem.bgImageDeSelected = data.deSelect
           }
       }
   
    
    let menuItem : MenuButton = {
        let btn = MenuButton()
        btn.titleLabel?.font = UIFont.init(name: "OpenSans-SemiBold", size: 16)
        return btn
    }()
        
       override init(frame: CGRect) {
           super.init(frame: .zero)
            
         
        addSubview(menuItem)
        menuItem.anchor(top: contentView.topAnchor, left:  leftAnchor, bottom: nil, right: nil, paddingTop:
                            0 , paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 85   , height: 85)
        
        
       }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
