 //
//  LightPagerViewContoller.swift
//  LightSwiftPager
//
//  Created by AHMED NASSER on 5/13/18.
//  Copyright © 2018 AHMED NASSER. All rights reserved.
//

import Foundation
import UIKit
 @objc
 public protocol LightPagerDelegate {
    @objc optional func didSelectTab(tab :LightPagerViewContoller , index:Int)
}
 public protocol LightPagerDataSource {
     func tapItems() ->[TapItem]
     func viewContollers() ->[UIViewController]

}
open  class LightPagerViewContoller :UIViewController,LightPagerDelegate,LightPagerDataSource {
    private  let stackView   = UIStackView()
    private let scrollView =  UIScrollView()
    private let indicatorView = UIView()
    private  let tapView = UIView()
    private  let contollersView = UIView()
    private let screenWidth = UIScreen.main.bounds.width
    private var stackTrailing :NSLayoutConstraint?
    private var items : [TapItem]? {
        didSet {
            self.tabs = (items?.count)!
        }
    }
    private var contollers :[UIViewController]?
    var delegate :LightPagerDelegate?
    var dataSource :LightPagerDataSource?
    private var tabs: Int = 0{
        didSet {
            if tabs > 0 {
                buttonWidth = (screenWidth / CGFloat(tabs) > 100 ) ? screenWidth - 50 / CGFloat(tabs) :100
                for index in 1...tabs {
                    let button = TapButton()
                    button.setItem(items![index - 1] )
                    button.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
                    button.actionBlock = { button in
                        self.currentTap = index - 1
                    }
                    button.translatesAutoresizingMaskIntoConstraints = false
                    stackView.addArrangedSubview(button)
                }
        
            }else{
                buttonWidth = 100
            }
            addView(index: 0)
        }
        
    }
   private var buttonWidth :CGFloat = 0 {
        didSet{
            scrollView.addConstraint(NSLayoutConstraint(item: indicatorView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: buttonWidth))
        }
    }
   private var currentTap :Int = 0 {
        didSet {
            let paging = CGFloat(currentTap - pastTap)
            let offsetX = ( paging != 0) ? ( self.buttonWidth +  16) * paging : 0
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.2) {
                self.indicatorLeading?.constant += offsetX
                let scrollOffset = self.indicatorLeading?.constant
                if scrollOffset! > self.view.frame.size.width - self.buttonWidth {
                    self.scrollView.contentOffset.x +=  (paging > 0) ? self.buttonWidth +  16 :  -(self.buttonWidth +  16)
                }else{
                    self.scrollView.contentOffset.x  =  0
                }
                self.view.layoutIfNeeded()
                
            }
            
            pastTap =  currentTap
            addView(index: currentTap)
            
            self.delegate?.didSelectTab?(tab: self, index: currentTap)


        }
    }
   private var pastTap : Int = 0
   private var indicatorLeading :NSLayoutConstraint?

    override open func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    func commonInit(){
        stackView.axis  = .horizontal
        stackView.distribution  = .equalSpacing
        stackView.alignment = UIStackViewAlignment.center
        stackView.spacing   = 16.0
        
        scrollView.bounces = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false 
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        tapView.translatesAutoresizingMaskIntoConstraints = false
        contollersView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        scrollView.addSubview(indicatorView)
        tapView.addSubview(scrollView)
        self.view.addSubview(tapView)
        self.view.addSubview(contollersView)
        addConstraint()
        
        indicatorView.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        tapView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.didSwipe(_:)))
        swipeRight.direction = .right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.didSwipe(_:)))
        swipeLeft.direction = .left
        self.contollersView.addGestureRecognizer(swipeLeft)
        self.contollersView.addGestureRecognizer(swipeRight)
        
        delegate = self
        dataSource = self
        
      
    }
    //Mark :reloading data
   open func reloadTaps() {
        self.contollers = dataSource?.viewContollers()
        self.items = dataSource?.tapItems()
    }
    //Mark : DataSource
    open func tapItems() -> [TapItem] {
        if type(of: self) !== LightPagerViewContoller.self {
            fatalError("subclass must implement tapItems")
        }
        return [TapItem]()
    }
   open func viewContollers() -> [UIViewController] {
        assertionFailure("Sub-class must implement the LightPagerDataSourceDataSource viewContollers method")
        return []
    }
    //set background
    open func setTapBackgroundColor (_ color:UIColor){
        self.tapView.backgroundColor = color
    }
    open func setIndicatorBaackGroundColor(_ color:UIColor) {
        self.indicatorView.backgroundColor = color
    }
    
   
}
 // Mark  : adding contollers
 extension LightPagerViewContoller {
    //swipe views
    @objc fileprivate func didSwipe(_ gesture :UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            if currentTap < tabs - 1{
                self.currentTap += 1
            }
            
        }else if gesture.direction == .right {
            if currentTap > 0 {
                self.currentTap -= 1
            }
        }
        
    }
    
    fileprivate  func addSubView(contentView :UIViewController,toView :UIViewController,containerView :UIView)  {
        
        toView.addChildViewController(contentView)
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        // remove sub views
        for suview in containerView.subviews{
            suview.removeFromSuperview()
        }
        containerView.addSubview((contentView.view)!)
        
        // add constraint to subview
        NSLayoutConstraint.activate([
            (contentView.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0)),
            (contentView.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0)),
            (contentView.view.topAnchor.constraint(equalTo: containerView.topAnchor)),
            (contentView.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor))
            ])
        
        contentView.didMove(toParentViewController: toView)
    }
    fileprivate func addView(index :Int)  {
        if self.contollers != nil{
            if currentTap < (contollers?.count)! {
                self.addSubView(contentView: contollers![currentTap], toView: self, containerView: contollersView)
            }else{
                assertionFailure("Taps count should be equal to view contollers .")
                
            }
        }else {
            assertionFailure("You haven't set viewContollers Yet .")
        }
        
    }

 }
extension LightPagerViewContoller {
   fileprivate func addConstraint()  {
        
        self.view.addConstraint(NSLayoutConstraint(item: tapView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 20))
        self.view.addConstraint(NSLayoutConstraint(item: tapView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: tapView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: contollersView, attribute: .top, relatedBy: .equal, toItem: self.tapView, attribute: .bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: contollersView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: contollersView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: contollersView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0))
        
        self.tapView.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: self.tapView, attribute: .top, multiplier: 1, constant: 5))
        self.tapView.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: self.tapView, attribute: .bottom, multiplier: 1, constant: -5))
        self.tapView.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: self.tapView, attribute: .leading, multiplier: 1, constant: 10))
        self.tapView.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: self.tapView, attribute: .trailing, multiplier: 1, constant: 10))
        
        scrollView.addConstraint(NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 0))
        scrollView.addConstraint(NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leading, multiplier: 1, constant: 10))
        scrollView.addConstraint(NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: scrollView, attribute: .trailing, multiplier: 1, constant: -10))
 
        
       scrollView.addConstraint(NSLayoutConstraint(item: indicatorView, attribute: .top, relatedBy: .equal, toItem: stackView, attribute: .bottom, multiplier: 1, constant: -5))
        indicatorLeading = NSLayoutConstraint(item: indicatorView, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leading, multiplier: 1, constant: 10)
        scrollView.addConstraint(indicatorLeading!)
        scrollView.addConstraint(NSLayoutConstraint(item: indicatorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 3))
        
        stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        
    }
}
