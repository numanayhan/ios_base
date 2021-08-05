//
//  MenuBar.swift
//  iBase
//
//  Created by Numan Ayhan on 4.08.2021.
//

import UIKit

protocol MenuBarDelegate: AnyObject {
    func didSelectItemAt(index: Int)
}

class MenuBar: UIView {
    
    let home: MenuButton!
    let crossSell: MenuButton!
    let activities: MenuButton!
//    let opportunities: UIButton!
//    let contacts: UIButton!
//    let address: UIButton!
//    let notes: UIButton!
//    let contracts:UIButton!
    
    var buttons: [UIButton]!
    
    
    let leadPadding: CGFloat = 16
    let buttonSpace: CGFloat = 36
    
    weak var delegate: MenuBarDelegate?
    
//    let names = ["Home","CrossSell","Activities","Opportunities"
//                 ,"Contacts","Address","Notes","Contracts"]
    override init(frame: CGRect) {
        
        home = makeButton(withText: "homed")
        crossSell = makeButton(withText: "homed")
        activities = makeButton(withText: "homed")
        
        buttons = [home, crossSell, activities]
        
        super.init(frame: .zero)
        
        home.addTarget(self, action: #selector(homeTapped), for: .primaryActionTriggered)
        crossSell.addTarget(self, action: #selector(crossSellTapped), for: .primaryActionTriggered)
        activities.addTarget(self, action: #selector(activitiesTapped), for: .primaryActionTriggered)
        
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        
        addSubview(home)
        addSubview(crossSell)
        addSubview(activities)
        
        NSLayoutConstraint.activate([
            // Buttons
            home.topAnchor.constraint(equalTo: topAnchor),
            home.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadPadding),
            crossSell.topAnchor.constraint(equalTo: topAnchor),
            crossSell.leadingAnchor.constraint(equalTo: home.trailingAnchor, constant: buttonSpace),
            activities.topAnchor.constraint(equalTo: topAnchor),
            activities.leadingAnchor.constraint(equalTo: crossSell.trailingAnchor, constant: buttonSpace),
            
        ])
        
    }
}

extension MenuBar {
    
    @objc func homeTapped() {
        print("homeTapped")
        delegate?.didSelectItemAt(index: 0)
    }
    
    @objc func crossSellTapped() {
        print("crossSellTapped")
        delegate?.didSelectItemAt(index: 1)
    }
    @objc func activitiesTapped() {
        print("activitiesTapped")
        delegate?.didSelectItemAt(index: 2)
    }
    
}
 

func makeButton(withText text: String) -> MenuButton {
    let button = MenuButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: .normal)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
//    button.cornerRadius = button.frame.width / 2
    return button
}
