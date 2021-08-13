//
//  Login.swift
//  iBase
//
//  Created by Melike Büşra Ayhan on 7.07.2021.
//

import UIKit
import Alamofire
class Login: UIViewController, TokenHandler  {
    
    lazy var popup : UIView = {
       let view = UIView()
        view.addSubview(login)
        login.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop:
                        self.view.frame.height / 2  - 20 , paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: self.view.frame.width - 40, height: 54)
        
        view.blur()
        
        return view
    }()
    lazy var blurView : UIView = {
       let view = UIView()
         
        view.blur()
        return view
    }()
    let login : MenuButton = {
        let btn = MenuButton()
//        btn.bgImageDeSelected = UIImage.init(named: "home")!
//        btn.bgImageSelected = UIImage.init(named: "homed")!
//        btn.selectedText = "Login"
//        btn.setTitleColor(UIColor.red, for: .normal)
        btn.addTarget(self, action: #selector(logined(_:)), for: .touchUpInside)
        return btn
    }()
    let request = DefaultRequest()
    override func viewDidLoad() {
        super.viewDidLoad() 
        layout()
         
    }
    func layout(){
        
        view.backgroundColor = UIColor.hex("#6D5EF7")
        view.addSubview(login)
        login.active = false
        login.bgImageDeSelected = UIImage.init(named: "home")!
        login.bgImageSelected = UIImage.init(named: "homed")!
        login.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop:
                        self.view.frame.height / 2  - 20 , paddingLeft: self.view.frame.width / 2  - 27, paddingBottom: 0, paddingRight: 0, width: 90, height: 90)
        
        
    }
    @objc func logined(_ sender:Any){
       
          
        
        print("login")
        request.genericRequest(url: URL(string: "https://dev-api.netcrm.dev/Login")!, expecting: LoginPost.self, attendences: "e") { response in
            print(response)
        }
        
    }
 

}
