//
//  SlideCollection.swift
//  iBase
//
//  Created by Numan Ayhan on 6.08.2021.
//

import UIKit

struct SlideData {
    var title: String
    var select: UIImage
    var deSelect: UIImage
}

class SlideCollection: UIViewController {
    fileprivate let collectionView:UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        
        cv.register(SlideCell.self, forCellWithReuseIdentifier: "cell")
            return cv
        }()
    fileprivate let data = [
        SlideData(title: "Anasayfa",   select: #imageLiteral(resourceName: "homed"),deSelect:#imageLiteral(resourceName: "home")),
        SlideData(title: "Çapraz Satış",   select: #imageLiteral(resourceName: "csrossSelled"),deSelect:#imageLiteral(resourceName: "csrossSell")),
        SlideData(title: "Aktiviteler",   select: #imageLiteral(resourceName: "activitiesed"),deSelect:#imageLiteral(resourceName: "activities")),
        SlideData(title: "İş Fırsatı",   select: #imageLiteral(resourceName: "joboppod"),deSelect:#imageLiteral(resourceName: "joboppo")),
        SlideData(title: "Kontaklar",   select: #imageLiteral(resourceName: "contacted"),deSelect:#imageLiteral(resourceName: "contact")),
        SlideData(title: "Adresler",   select: #imageLiteral(resourceName: "addressed"),deSelect:#imageLiteral(resourceName: "address")),
        SlideData(title: "Notlar",   select: #imageLiteral(resourceName: "noted"),deSelect:#imageLiteral(resourceName: "not")),
        SlideData(title: "Kontratlar",   select: #imageLiteral(resourceName: "noted"),deSelect:#imageLiteral(resourceName: "not")),
       ]
    override func viewDidLoad() {
        super.viewDidLoad()
 
        view.backgroundColor = .white
        
        setCollection()
    }
    func setCollection(){
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.hex("#6D5EF7")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft:
                                10, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 135)
        
    }

}
extension SlideCollection: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135 , height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SlideCell
        
        if indexPath.row == 0{
            cell.menuItem.active = true
        }else{
            cell.menuItem.active = false
        }
        cell.data = self.data[indexPath.item]
        return cell
    }
}
