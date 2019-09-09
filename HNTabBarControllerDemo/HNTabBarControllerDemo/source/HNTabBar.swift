//
//  HNTabBar.swift
//  HNEventBus
//
//  Created by liuxn on 2019/3/29.
//  Copyright © 2019 liuxn. All rights reserved.
//

import UIKit

protocol HNTabBarDelegate: class {
    func didSelectedItem(_ index: Int)
}

class HNTabBar: UIView {
    let items: [HNTabBarItemConfig]!
    var tabBarItems = [HNTabBaritem]()
    var selectedIndex: Int = 0 {
        didSet {
            for item in tabBarItems {
                item.isSelected = (item.index == selectedIndex)
            }
        }
    }
    
    weak var delegate: HNTabBarDelegate?
    
    init(frame: CGRect, items: [HNTabBarItemConfig], selectedIndex: Int = 0) {
        self.items = items
        super.init(frame: frame)
        setupUI(selectedIndex)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(_ index: Int) {
        let itemW: CGFloat = HNScreenWidth/CGFloat(items.count)
        for i in 0 ..< items.count {
            let itemModel = items[i]
            let tabBarItem = HNTabBaritem(frame: CGRect(x: CGFloat(i)*itemW, y: 0, width: itemW, height: self.bounds.height), itemConfig: itemModel)
            addSubview(tabBarItem)
            tabBarItem.index = i
            tabBarItem.addTarget(self, action: #selector(didSeleted(sender:)), for: .touchUpInside)
            tabBarItems.append(tabBarItem)
            if index == i {
                self.selectedIndex = index
            }
        }
    }
    
    @objc func didSeleted(sender: HNTabBaritem) {
        sender.isSelected = true
        selectedIndex = sender.index
        self.delegate?.didSelectedItem(selectedIndex)
    }
    
    func setBadge(_ badge: String?, index: Int) {
        let item = tabBarItems[index]
        item.badge = badge
    }
    
}
