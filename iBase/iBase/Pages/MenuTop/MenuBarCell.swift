//
//  HomeCell.swift
//  iBase
//
//  Created by Numan Ayhan on 4.08.2021.
//
import Foundation
import UIKit

class MenuBarCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") 
    }
    
    func layout() {
        backgroundColor = .white
    }
    
}
