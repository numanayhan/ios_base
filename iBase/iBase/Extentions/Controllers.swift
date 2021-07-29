//
//  Controllers.swift
//  iBase
//
//  Created by Melike Büşra Ayhan on 7.07.2021.
//

import Foundation
import UIKit

extension UIViewController{
    
    func add(_ child: UIViewController){
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self )
    }
    func remove(){
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    
    
}
