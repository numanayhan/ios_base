//
//  MenuBar.swift
//  iBase
//
//  Created by Numan Ayhan on 1.08.2021.
//

import UIKit

class TopMenu: UIViewController {

    var firstTab : UIBarButtonItem!
    var secondTab : UIBarButtonItem!
    let container = Container()
    let viewControllers : [UIViewController] = [FirstTab(),SecondTab()]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setBarTypes()
        
        navigationItem.leftBarButtonItems  = [firstTab,secondTab]
         
        setTabViews()
    }
    func setTabViews(){
        guard let  cv = container.view  else {
            return
        }
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .red 
        view.addSubview(cv)
        NSLayoutConstraint.activate([
            cv.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            cv.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cv.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cv.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    
        
        music()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setLayout()
        
    }
    func setLayout(){
        self.view.backgroundColor = .black
        if navigationController != nil{
            
            navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationController!.navigationBar.isTranslucent = false
            navigationController?.navigationBar.backgroundColor = .black
            self.navigationController?.navigationBar.barStyle = UIBarStyle.default
//            //Navbar arkaplan rengini dğeiştirir.
            self.navigationController?.navigationBar.barTintColor  = UIColor.black
            
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
    }
    func setBarTypes(){
        firstTab   = makeItem("Music", selector: #selector(music))
        secondTab   = makeItem("Room", selector: #selector(room))
        
    }
    @objc func music(){
        
        if container.children.first == viewControllers[0] { return }
        
        container.add(viewControllers[0])
                
        animateTransition(fromVC: viewControllers[1], toVC: viewControllers[0], vcs: viewControllers) {success in
            self.viewControllers[1].remove()
        } 
        UIView.animate(withDuration: 0.5) {
            self.firstTab.customView?.alpha = 1.0
            self.secondTab.customView?.alpha = 0.5
        }
    }
    @objc func room(){
        if container.children.first == viewControllers[1] { return }
        
        container.add(viewControllers[1])
        
        animateTransition(fromVC: viewControllers[0], toVC: viewControllers[1], vcs: viewControllers) {success in
            self.viewControllers[0].remove()
        }
        UIView.animate(withDuration: 0.5) {
            self.firstTab.customView?.alpha = 0.5
            self.secondTab.customView?.alpha = 1.0
        }
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func makeItem(_ text:String, selector:Selector) -> UIBarButtonItem{
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: selector, for: .primaryActionTriggered)
        let lineattribute : [NSAttributedString.Key : Any] = [
            .foregroundColor : UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 30)
        ]
        let attributeString = NSMutableAttributedString(string: text, attributes: lineattribute)
        
        btn.setAttributedTitle(attributeString, for: .normal)
        btn.contentEdgeInsets  = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 16)
        let barItem = UIBarButtonItem(customView: btn)
        return barItem
    }
}



