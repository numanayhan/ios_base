//
//  Alert.swift
//  iBase
//
//  Created by Numan Ayhan on 24.07.2021.
//

import Foundation
import UIKit

extension UIViewController {
    
    func alert(_ title:String , _ msg:String ){
        
        let alert = UIAlertController(title:title, message: msg, preferredStyle: .alert)
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
          // your code with delay
          alert.dismiss(animated: true, completion: nil)
        }
        self.present(alert, animated: true)
    }
    func alertAction(_ title:String , _ msg:String  )  {
        
        let alert = UIAlertController(title:title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "done".localized(), style: .cancel, handler: nil))
         
        self.present(alert, animated: true)
    }
}
