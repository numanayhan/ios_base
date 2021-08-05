//
//  MenuTop.swift
//  iBase
//
//  Created by Numan Ayhan on 1.08.2021.
//

import UIKit

class MenuTop: UIViewController {
    let menuBar = MenuBar()
    let cellId = "MenuCell"
    
    lazy var collectionView : UICollectionView = {
        var cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.isPagingEnabled = true
        return cv
    }()
    let colors : [UIColor] = [.systemRed,.systemPink,.systemBlue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        setLayout()
        menuBar.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBar()
         
    }
    func setNavigationBar() {
        
        if navigationController != nil{
            navigationController?.navigationBar.backgroundColor  = .white
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationController?.navigationBar.isHidden = false
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.backgroundColor = .white
            self.navigationController?.navigationBar.barStyle = UIBarStyle.default
            
            self.navigationController?.navigationBar.barTintColor  = UIColor.hex("#6D5EF7")
            
        self.navigationItem.setHidesBackButton(true, animated:false)
        //özel back image oluşturuldu.
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let leftBarButtonItem = UIBarButtonItem(customView: view)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        //Sayfa bağlığı eklendi.
        self.navigationItem.title = "Müşteri"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        //Arkaplan shadow ve renkleri kaldırıldı
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor  = UIColor.clear
        navigationController?.navigationBar.shadowImage = UIImage()
        //Title Renklendirmesi verildi.
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:  UIColor.white]
        }
    }
     
    func setLayout(){
        
        self.view.backgroundColor = UIColor.hex("#6D5EF7")
        
        setMenuBar()
        
    }
    func setMenuBar(){
        
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.backgroundColor = .lightGray
        view.addSubview(menuBar)
        
        menuBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 42)
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
            
            collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        }
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.anchor(top: menuBar.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
        
         
        collectionView.reloadData()
        
    }
     
}
extension MenuTop : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuBarCell
        cell.backgroundColor = colors[indexPath.row]
            
        return cell
    }


}
extension MenuTop : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
}
extension MenuTop: MenuBarDelegate {
    func didSelectItemAt(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        print(indexPath)
        //collectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
}
