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
    
    let home: UIButton!
    let crossSell: UIButton!
    let activities: UIButton!
//    let opportunities: UIButton!
//    let contacts: UIButton!
//    let address: UIButton!
//    let notes: UIButton!
//    let contracts:UIButton!
    
    var buttons: [UIButton]!
    let indicator = UIView()
    
    var indicatorLeading: NSLayoutConstraint?
    var indicatorTrailing: NSLayoutConstraint?

    
    let leadPadding: CGFloat = 26
    let buttonSpace: CGFloat = 36
    
    weak var delegate: MenuBarDelegate?
    
//    let names = ["Home","CrossSell","Activities","Opportunities"
//                 ,"Contacts","Address","Notes","Contracts"]
    override init(frame: CGRect) {
        
        home = makeButton(withText: "homed")
        crossSell = makeButton(withText: "homed")
        activities = makeButton(withText: "homed")
        
        buttons = [home, crossSell, activities]
//        if buttons.first != nil
//        {
//            home.active = true
//        }
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
//        addSubview(indicator)
        
        NSLayoutConstraint.activate([
            home.topAnchor.constraint(equalTo: topAnchor),
            home.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadPadding),
            crossSell.topAnchor.constraint(equalTo: topAnchor),
            crossSell.leadingAnchor.constraint(equalTo: home.trailingAnchor, constant: buttonSpace),
            activities.topAnchor.constraint(equalTo: topAnchor),
            activities.leadingAnchor.constraint(equalTo: crossSell.trailingAnchor, constant: buttonSpace),
//            // bar
//            indicator.bottomAnchor.constraint(equalTo: bottomAnchor),
//            indicator.heightAnchor.constraint(equalToConstant: 3)
        ])
        indicatorLeading = indicator.leadingAnchor.constraint(equalTo: home.leadingAnchor)
        indicatorTrailing = indicator.trailingAnchor.constraint(equalTo: home.trailingAnchor)
        
//        indicatorLeading?.isActive = true
//        indicatorTrailing?.isActive = true
     
        selectItem(at: 0)
        
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
 
extension MenuBar {
    
    func selectItem(at index: Int) {
         animateIndicator(to: index)
    }
    private func animateIndicator(to index: Int) {
        var button: UIButton
        switch index {
        case 0:
            button = home
        case 1:
            button = crossSell
        case 2:
            button = activities
        default:
            button = home
        }
        setAlpha(for: button)
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    private func setAlpha(for button: UIButton) {
        home.alpha = 0.5
        crossSell.alpha = 0.5
        activities.alpha = 0.5
        button.alpha = 1.0
    }
    func scrollIndicator(to contentOffset: CGPoint) {
        let index = Int(contentOffset.x / frame.width)
        let atScrollStart = Int(contentOffset.x) % Int(frame.width) == 0
        
        if atScrollStart {
            return
        }
        
        // determine percent scrolled relative to index
        let percentScrolled: CGFloat
        switch index {
        case 0:
             percentScrolled = contentOffset.x / frame.width - 0
        case 1:
            percentScrolled = contentOffset.x / frame.width - 1
        case 2:
            percentScrolled = contentOffset.x / frame.width - 2
        default:
            percentScrolled = contentOffset.x / frame.width
        }
        
        // determine buttons
        var fromButton: UIButton
        var toButton: UIButton
        
        switch index {
        case 2:
            fromButton = buttons[index]
            toButton = buttons[index - 1]
        default:
            fromButton = buttons[index]
            toButton = buttons[index + 1]
        }
        
        // animate alpha of buttons
        switch index {
        case 2:
            break
        default:
            fromButton.alpha = fmax(0.5, (1 - percentScrolled))
            toButton.alpha = fmax(0.5, percentScrolled)
        }
        
        let fromWidth = fromButton.frame.width
        let toWidth = toButton.frame.width
        
        // determine width
        let sectionWidth: CGFloat
        switch index {
        case 0:
            sectionWidth = leadPadding + fromWidth + buttonSpace
        default:
            sectionWidth = fromWidth + buttonSpace
        }

        // normalize x scroll
        let sectionFraction = sectionWidth / frame.width
        let x = contentOffset.x * sectionFraction
        
        let buttonWidthDiff = fromWidth - toWidth
        let widthOffset = buttonWidthDiff * percentScrolled

        // determine leading y
        let y:CGFloat
        switch index {
        case 0:
            if x < leadPadding {
                y = x
            } else {
                y = x - leadPadding * percentScrolled
            }
        case 1:
            y = x + 13
        case 2:
            y = x
        default:
            y = x
        }
        
        // Note: 13 is button width difference between Playlists and Artists button
        // from previous index. Hard coded for now.
        
        indicatorLeading?.constant = y

        // determine trailing y
        let yTrailing: CGFloat
        switch index {
        case 0:
            yTrailing = y - widthOffset
        case 1:
            yTrailing = y - widthOffset - leadPadding
        case 2:
            yTrailing = y - widthOffset - leadPadding / 2
        default:
            yTrailing = y - widthOffset - leadPadding
        }
        
        indicatorTrailing?.constant = yTrailing
        
    }
}
func makeButton(withText text: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: .normal)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
//    button.cornerRadius = button.frame.width / 2
    return button
}
