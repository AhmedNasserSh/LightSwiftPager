//
//  TapButton.swift
//  collectionView
//
//  Created by AHMED NASSER on 5/25/18.
//  Copyright © 2018 AHMED NASSER. All rights reserved.
//

import UIKit

class TapButton: UIView {
    let titleLabel = UILabel()
    private let image = UIImageView()
    private let stackView = UIView()
    var actionBlock : ((TapButton) -> Void )?
    private var width :CGFloat?
    private var item :TapItem?
    private var labelTopConstraint :NSLayoutConstraint?
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    func commonInit() {
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        image.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addSubview(image)
        stackView.addSubview(titleLabel)

        self.addSubview(stackView)

        addConstriant()
        
        
        let action = UITapGestureRecognizer(target: self, action: #selector(self.didTap(_:)))
        self.addGestureRecognizer(action)

        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
     func setItem(_ item:TapItem)  {
        if item.image == nil && item.title == nil {
            return
        }
        if item.image != nil {
            image.image = item.image
        }else{
            image.removeFromSuperview()
            self.removeConstraint(labelTopConstraint!)
            stackView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: stackView, attribute: .top, multiplier: 1, constant: 10))

        }
        if item.title != nil{
            titleLabel.text = item.title
        }else{
            titleLabel.removeFromSuperview()
            self.removeConstraint(labelTopConstraint!)
            stackView.addConstraint(NSLayoutConstraint(item: image, attribute: .bottom, relatedBy: .equal, toItem: stackView, attribute: .bottom, multiplier: 1, constant: -5))

        }
    }
    func setTitlteColor(_ color :UIColor){
        self.titleLabel.textColor = color
    }
    @objc private func didTap(_ sender :UITapGestureRecognizer)  {
        actionBlock!(self)
    }
   private func addConstriant() {
        self.addConstraint(NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 5))
        self.addConstraint(NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -5))
        self.addConstraint(NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        
        stackView.addConstraint(NSLayoutConstraint(item: image, attribute: .top, relatedBy: .equal, toItem: stackView, attribute: .top, multiplier: 1, constant: 10))
        stackView.addConstraint(NSLayoutConstraint(item: image, attribute: .centerX, relatedBy: .equal, toItem: stackView, attribute: .centerX, multiplier: 1, constant: 0))
        stackView.addConstraint(NSLayoutConstraint(item: image, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
        stackView.addConstraint(NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
        
        labelTopConstraint = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: image, attribute: .bottom, multiplier: 1, constant: 10)
        stackView.addConstraint(labelTopConstraint!)

        stackView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: stackView, attribute: .bottom, multiplier: 1, constant: -5))
        stackView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: stackView, attribute: .trailing, multiplier: 1, constant: 0))
        stackView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: stackView, attribute: .leading, multiplier: 1, constant: 0))



    }
    
}
