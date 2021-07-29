//
//  HeaderView.swift
//  iBase
//
//  Created by Numan Ayhan on 28.07.2021.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
   let view : UIImageView = {
        let view = UIImageView()
    view.image = UIImage.init(named: "header")
    view.contentMode = .scaleToFill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout(){
        
        
        addSubview(view)
        view.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width, height: frame.height)
        
        //blur
        setupVisualEffectBlur()
        
    }
    
    var animator: UIViewPropertyAnimator!
    
    fileprivate func setupVisualEffectBlur() {
        animator = UIViewPropertyAnimator(duration: 3.0, curve: .linear, animations: { [weak self] in
            
            // treat this area as the end state of your animation
            let blurEffect = UIBlurEffect(style: .regular)
            let visualEffectView = UIVisualEffectView(effect: blurEffect)
            
            self?.addSubview(visualEffectView)
            visualEffectView.fillSuperview()
        })
        
    }
}
