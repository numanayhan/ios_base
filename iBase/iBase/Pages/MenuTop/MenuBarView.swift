//
//  MenuBarView.swift
//  iBase
//
//  Created by Numan Ayhan on 5.08.2021.
//

import UIKit

class MenuBarView: UIView {
    private let cellId = "MenuBarViewCell"
    var items = ["home","crossSell","activities"]
    lazy var collectionView :UICollectionView  = {
        
        var cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        
        return cv
    }()
    let colors : [UIColor] = [.systemRed,.cyan,.systemBlue]
    var contentViewSize = CGSize.init()
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        contentViewSize = CGSize.init(width:  frame.width, height: 130)
        backgroundColor = .red
        
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            flowLayout.minimumInteritemSpacing = 0 // item arasındaki boşluk  0
            flowLayout.minimumLineSpacing =  0     // line arasındaki mesafe 1
            collectionView.isPagingEnabled = true
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        }
        collectionView.backgroundColor = .clear
        collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        collectionView.anchor(top:  topAnchor, left:  leftAnchor, bottom: bottomAnchor, right:  rightAnchor, paddingTop:  0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width:  frame.width, height:  130)
        
        
        collectionView.reloadData()
        
    }
}
extension MenuBarView : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuBarCell
        cell.backgroundColor = colors[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return contentViewSize
    }
    
}
