//
//  LangList.swift
//  iBase
//
//  Created by Numan Ayhan on 26.07.2021.
//

import UIKit

class LangList: UIViewController {
 
    var language: [Language] = [.korean, .english(.us), .english(.uk), .english(.australian), .english(.canadian), .english(.indian),
                                .chinese(.simplified), .chinese(.traditional), .chinese(.hongKong),
                                .japanese]
    
    lazy var tableView : UITableView  = {
        var tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setNavbar()
        setTableView()
        print(Locale.current.currencyCode)
        print(Locale.current.languageCode)
        for l in language {
            
            
            if Locale.current.languageCode  == l.code{
                
                Language.init(languageCode:Locale.current.languageCode )
            }else{
                Language.init(languageCode:"en")
            }
        }
        
        //Bundle.set(language: languages[indexPath.row].language)
        
    }
    func setLayout(){
     
        view.backgroundColor = .white
        
    }
    func setNavbar(){
        //NAvigation Bar Özelleştirildi.
        //Navigation geri butonu kapatıldı.
        self.navigationItem.setHidesBackButton(true, animated:false)
        let left : UIButton = {
           let button  = UIButton()
            button.setTitleColor(Colors.navbarText, for: .normal)
            button.setTitle("cancel".localized(), for: .normal)
            button.addTarget(self,  action: #selector(backForward), for:.touchUpInside )
            return button
        }()
        let leftBarButtonItem = UIBarButtonItem(customView: left)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        //ok butonu
        let right : UIButton = {
           let button  = UIButton()
            button.setTitleColor(Colors.pink, for: .normal)
            button.setTitle("done".localized(), for: .normal)
            return button
        }()
        let rightBarButtonItem = UIBarButtonItem(customView: right)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        //Sayfa bağlığı eklendi.
        self.navigationItem.title = "lang".localized()
        //Arkaplan shadow ve renkleri kaldırıldı
        let navbarLine = UIView(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: 0.2))
        navbarLine.backgroundColor = Colors.navbarLine ///
        navigationController?.navigationBar.addSubview(navbarLine)
         
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor  = UIColor.clear
        navigationController?.navigationBar.shadowImage = UIImage()
        //Title Renklendirmesi verildi.
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
    }
    @objc func backForward(){
        print("back")
    }
    func setTableView(){
        tableView.register(LangCell.self , forCellReuseIdentifier: "LangCell")
        tableView.reloadData()
    }
}
extension LangList : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return language.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell (withIdentifier: "LangCell",for: indexPath) as? LangCell {
            cell.textLabel?.text = language[indexPath.row].name
            return cell
        }
        return UITableViewCell()
    }
    
    
}
