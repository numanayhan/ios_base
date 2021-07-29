//
//  ScrollableTabView.swift
//  iBase
//
//  Created by Numan Ayhan on 27.07.2021.
//

import UIKit
import Foundation
//public protocol ScrollableDelegate:AnyObject{
//    func scrollable(_ tableView: ScrollableTabView, didTabAt index: Int)
//}

class FirstTab: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
    }
    
    func setLayout(){
        view.backgroundColor = .green
        print("first")
    }
}
class SecondTab: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    func setLayout(){
        view.backgroundColor = .red
        print("second")
    }
}
class Container: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    func setLayout(){
        
        view.backgroundColor = .black
        
    }
}
class TitleBar: UIViewController {
    
    var firstTab : UIBarButtonItem!
    var secondTab : UIBarButtonItem!
    let container = Container()
    let viewControllers : [UIViewController] = [FirstTab(),SecondTab()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setNavbar()
        setViews()
    }
    func setLayout(){
        
        view.backgroundColor = .black
        
    }
    func setViews(){
        
        guard let cv = container.view else {return}
        cv.backgroundColor = .systemPink
        view.addSubview(cv)
        cv.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
     
        if container.children.first == viewControllers[0]{
            return
        }
        container.add(viewControllers[0])
        
        self.viewControllers[1].remove()
    }
    func setNavbar(){
        
        navigationItem.leftBarButtonItems = [firstTab,secondTab]
        
        let img = UIImage()
        self.navigationController?.navigationBar.shadowImage = img
        self.navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .black
        
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        firstTab  = barButtonItem(text: "First", selector: #selector(firstTabAction))
        secondTab  = barButtonItem(text: "Second", selector: #selector(secondTabAction))
    }
    required init?(coder: NSCoder) {
        fatalError("error bar")
    }
    @objc func firstTabAction( ){
        if container.children.first == viewControllers[0]{
            return
        }
        container.add(viewControllers[0])
        
        animeTab(viewControllers[1], viewControllers[0]) { success in
            self.viewControllers[1].remove()
        }
         
        UIView.animate(withDuration: 0.5){
            self.firstTab.customView?.alpha = 1.0
            self.secondTab.customView?.alpha = 0.5
        }
    
    }
    @objc func secondTabAction( ){
        if container.children.first == viewControllers[1]{
            return
        }
        container.add(viewControllers[1])
        
        animeTab(viewControllers[0], viewControllers[1]) { success in
            self.viewControllers[0].remove()
        }
        
        UIView.animate(withDuration: 0.5){
            self.firstTab.customView?.alpha = 0.3
            self.secondTab.customView?.alpha = 1.0
        }
    }
    
}
extension TitleBar{
    
    func barButtonItem(text:String, selector:Selector) -> UIBarButtonItem {
        let  button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints =  false
        button.addTarget(self , action: selector, for: .primaryActionTriggered)
        
        let attr = [
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body).withSize(12),NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        let attrText = NSMutableAttributedString(string: text,attributes: attr)
        button.setAttributedTitle(attrText, for: .normal)
        button.contentEdgeInsets  = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 16)
        
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }
    func animeTab(_ from:UIViewController, _ to: UIViewController, completion: @escaping ((Bool) ->Void)){
        guard
            let fromView = from.view,
            let fromIndex = getIndex(forIndex:from),
            let toView = to.view,
            let toIndex = getIndex(forIndex:to) else {
            return
        }
        let frame = from.view.frame
        var fromFrameEnd = frame
        var toFrameStart = frame
        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x  - frame.width : frame.origin.x + frame.width
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x  + frame.width : frame.origin.x + frame.width
        toView.frame = toFrameStart
        
        UIView.animate(withDuration: 0.5 , animations:{
            fromView.frame = fromFrameEnd
            toView.frame = frame
        },completion : { success in
           completion(success)
        })
    }
    func getIndex(forIndex vc :UIViewController ) -> Int?{
        for (index,tvc) in viewControllers.enumerated() {
            if tvc == vc { return index}
        }
        return nil
    }
}
class ScrollableTabView: UIView {

    let scrollView = UIScrollView()
    //var tabs: [TabView] = []
     
    
    func scrollable(_ tableView: ScrollableTabView, didTabAt index: Int){
        
    }
   
     
}
