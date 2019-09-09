//
//  HNBaseConfig.swift
//  HNEventBus
//
//  Created by liuxn on 2019/3/30.
//  Copyright © 2019 liuxn. All rights reserved.
//

import UIKit

let HNScreenWidth = UIScreen.main.bounds.size.width
let HNScreenHeight = UIScreen.main.bounds.size.height


class HNFont: UIFont {
    
    class func size(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
}
