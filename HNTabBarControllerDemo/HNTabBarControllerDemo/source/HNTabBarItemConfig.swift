//
//  HNTabBarItemConfig.swift
//  HNEventBus
//
//  Created by liuxn on 2019/3/29.
//  Copyright © 2019 liuxn. All rights reserved.
//

import UIKit

class HNTabBarItemConfig {
    let title: String
    let normalImage: String
    let selectedImage: String
    let normalTitleColor: UIColor
    let selectedTitleColor: UIColor
    
    init(title: String, normalImage: String, selectedImage: String, normalTitleColor: UIColor, selectedTitleColor: UIColor) {
        self.title = title
        self.normalImage = normalImage
        self.selectedImage = selectedImage
        self.normalTitleColor = normalTitleColor
        self.selectedTitleColor = selectedTitleColor
    }
    
}
