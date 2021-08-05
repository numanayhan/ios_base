//
//  Collection.swift
//  iBase
//
//  Created by Numan Ayhan on 2.08.2021.
//

import UIKit

class Collection: UIViewController , UICollectionViewDelegateFlowLayout{
    //UICollectionView oluşturulup FlowLayout eklendi.
    lazy var collection : UICollectionView = {
        var cv = UICollectionView(frame: .zero,collectionViewLayout: UICollectionViewFlowLayout())
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing =  1
        layout.sectionHeadersPinToVisibleBounds = true
        layout.sectionInsetReference = .fromSafeArea
        layout.itemSize = CGSize.init(width:  view.frame.width , height: 63)
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.isScrollEnabled = true
        cv.alwaysBounceVertical = true
        cv = UICollectionView.init(frame: .zero,collectionViewLayout: layout)
        return cv
    }()
    var collectionSize:CGSize? = CGSize.init(width: 0, height: 0)
    private let cellId = "CollectionViewCell"
    var collectionList = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    func setLayout(){
        setCV()
    }
    func setCV(){
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .white
        collectionSize = CGSize.init(width: view.frame.width, height: 63)
        let cellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collection.register(cellNib, forCellWithReuseIdentifier: cellId)
    
        view.addSubview(collection)
        collection.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: view.frame.width, height: view.frame.height)
        
        collection.reloadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setNavbar()
    }
    func setNavbar(){
        if navigationController != nil {
            navigationController?.navigationBar.backgroundColor  = .white
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationController?.navigationBar.isHidden = false
            view.backgroundColor =  .white
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionSize!
    }
     
}
extension Collection : UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //Search sonucu liste sayısı
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CollectionViewCell
        cell?.backgroundColor  = .lightGray
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath as IndexPath) as? CollectionViewCell

//        if cell?.isSelected == true {
//            cell?.imageView.image   = UIImage(named: "check")
//        }else if cell?.isSelected == false {
//            cell?.imageView.image   = UIImage(named: "noCheck")
//        }
    }
}
