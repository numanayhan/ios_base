//
//  MenuSubViewCell.swift
//  iBase
//
//  Created by Numan Ayhan on 5.08.2021.
//

import UIKit

class MenuSubViewCell: UICollectionViewCell {
    
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
