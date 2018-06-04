//
//  ViewController.swift
//  Example
//
//  Created by AHMED NASSER on 6/1/18.
//  Copyright © 2018 AHMED NASSER. All rights reserved.
//

import UIKit
import LightSwiftPager
class ViewController: LightPagerViewContoller {

    var taps = [TapItem]()
    var views = [UIViewController]()
    var colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)]
    override func viewDidLoad() {
        super.viewDidLoad()
        views.append((self.storyboard?.instantiateViewController(withIdentifier: "one"))!)
        views.append((self.storyboard?.instantiateViewController(withIdentifier: "two"))!)
        views.append((self.storyboard?.instantiateViewController(withIdentifier: "three"))!)
        
        taps.append(TapItem(title: "title"))
        taps.append(TapItem( image: UIImage(named: "one")))
        taps.append(TapItem( title: "title1",image: UIImage(named: "one")))

        setTapBackgroundColor(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1))
        setIndicatorBaackGroundColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        reloadTaps()
    }
    override func viewContollers() -> [UIViewController] {
        return views
    }
    override func tapItems() -> [TapItem] {
        return taps
    }
    func titelColors() -> [UIColor] {
        return colors
    }


}


