//
//  StretchyHeaderLayout.swift
//  iBase
//
//  Created by Numan Ayhan on 29.07.2021.
//

import UIKit

class StretchyHeaderLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttr = super.layoutAttributesForElements(in: rect)
        layoutAttr?.forEach({ attributes  in
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader && attributes.indexPath.section == 0 {
                guard let cv = collectionView else {
                    return
                }
                let contentY =  cv.contentOffset.y
                if contentY > 0{
                    return
                }
                
                let width = cv.frame.width
                let height = attributes.frame.height -  contentY
                
                attributes.frame = CGRect(x: 0, y: contentY, width: width, height: height)
                
            }
        })
        
        return layoutAttr
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
