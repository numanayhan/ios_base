//
//  CheckCell.swift
//  iBase
//
//  Created by Numan Ayhan on 30.07.2021.
//

import UIKit

class CheckCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func select(_ sender: Any?) {
        print(sender)
    }
    override var isHighlighted: Bool {
           willSet {
               onSelected(newValue)
           }
       }
        override var isSelected: Bool {
            willSet {
                onSelected(newValue)
            }
        }
    func onSelected(_ newValue: Bool) {
           // selectedBackgroundView is defined by UICollectionViewCell
           guard selectedBackgroundView == nil else { return }
            
       }
    
}
