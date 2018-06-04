//
//  TapItem.swift
//  collectionView
//
//  Created by AHMED NASSER on 5/26/18.
//  Copyright © 2018 AHMED NASSER. All rights reserved.
//

import UIKit
open class TapItem:NSObject {
    var title :String?
    var image :UIImage?
    public init(title :String? = nil,image :UIImage? = nil) {
        self.title = title
        self.image = image
    }
}
