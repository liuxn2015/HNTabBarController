//
//  HNTabBarController.swift
//  HNEventBus
//
//  Created by liuxn on 2019/3/29.
//  Copyright © 2019 liuxn. All rights reserved.
//

import UIKit

class HNTabBarController: UITabBarController {
    var myTabBar: HNTabBar!
    
    override var selectedIndex: Int {
        didSet {
            myTabBar.selectedIndex = selectedIndex
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeTabBarButton()
    }
    
    func addChildVC() {
        let feed = HNTabBarItemConfig(title: "首页", normalImage: "icon_tabbar_homedown", selectedImage: "icon_tabbar_homeup", normalTitleColor: .gray, selectedTitleColor: .blue)
        let comment = HNTabBarItemConfig(title: "广场", normalImage: "icon_tabbar_discoveryup", selectedImage: "icon_tabbar_discoveryup_selected", normalTitleColor: .gray, selectedTitleColor: .blue)
        let detail = HNTabBarItemConfig(title: "消息", normalImage: "ic_tabbar_notification", selectedImage: "ic_tabbar_notification_selected", normalTitleColor: .gray, selectedTitleColor: .blue)
        
        let items = [feed, comment, detail]
        myTabBar = HNTabBar(frame: self.tabBar.bounds, items: items, selectedIndex: 0)
        myTabBar.delegate = self
        tabBar.addSubview(myTabBar)
        tabBar.bringSubviewToFront(myTabBar)
        
        let home = HNHomeViewController()
        addChildrenController(home)
        let feedVC = HNFeedViewController()
        addChildrenController(feedVC)
        let profile = HNProfileViewController()
        addChildrenController(profile)
    }

    func addChildrenController(_ childController: UIViewController) {
        let navgationVC = UINavigationController(rootViewController: childController)
        addChild(navgationVC)
    }
    
    func removeTabBarButton() {
        for btn in tabBar.subviews {
            if btn.isKind(of: NSClassFromString("UITabBarButton")!) {
                    btn.isHidden = true
            }
        }
    }
    
    open func setBadge(_ badge: String?, index: Int) {
        myTabBar.setBadge(badge, index: index)
    }
    
}

extension HNTabBarController: HNTabBarDelegate {
    func didSelectedItem(_ index: Int) {
        self.selectedIndex = index
    }
}

extension UIViewController {
    func setTabBarBadge(_ badge: String?, index: Int) {
        if let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? HNTabBarController {
            tabBarController.setBadge(badge, index: index)
        }
    }
}
