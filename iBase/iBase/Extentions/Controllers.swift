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
        guard parent != nil  else {
            return
        }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func animateTransition(fromVC: UIViewController, toVC: UIViewController, vcs:[UIViewController], completion: @escaping ((Bool) -> Void)) {
        guard
            let fromView = fromVC.view,
            let fromIndex = getIndex(forViewController: fromVC, viewControllers: vcs),
            let toView = toVC.view,
            let toIndex = getIndex(forViewController: toVC, viewControllers: vcs)
            else {
                return
        }

        let frame = fromVC.view.frame
        var fromFrameEnd = frame
        var toFrameStart = frame
        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
        toView.frame = toFrameStart

        UIView.animate(withDuration: 0.5, animations: {
            fromView.frame = fromFrameEnd
            toView.frame = frame
        }, completion: {success in
            completion(success)
        })
    }

    func getIndex(forViewController vc: UIViewController,viewControllers:[UIViewController]) -> Int? {
        for (index, thisVC) in viewControllers.enumerated() {
            if thisVC == vc { return index }
        }
        return nil
    }
    
}
