
//
//  HNTabBaritem.swift
//  HNEventBus
//
//  Created by liuxn on 2019/3/29.
//  Copyright © 2019 liuxn. All rights reserved.
//

import UIKit

class HNTabBaritem: UIControl {
    let badgeWidth: CGFloat = 15
    let badgeDotWidth: CGFloat = 12
    let badgeMaxWidth: CGFloat = 30
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 12))
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = HNFont.size(10)
        label.sizeToFit()
        return label
    }()
    
    open var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    open var titleNormalColor: UIColor!
    open var titleSelectedColor: UIColor!
    
    private lazy var itemImage: UIImageView = {
        let image = UIImageView()
        image.center = self.center
        image.sizeToFit()
        return image
    }()
    
    open var normalImage: String!
    open var selectedImage: String!
    
    private lazy var badgeLabel: UILabel = {
        let badgeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: badgeWidth, height: badgeWidth))
        badgeLabel.backgroundColor = .red
        badgeLabel.font = HNFont.size(10)
        badgeLabel.layer.masksToBounds = true
        badgeLabel.layer.cornerRadius = badgeWidth/2
        badgeLabel.sizeToFit()
        badgeLabel.textColor = .white
        badgeLabel.textAlignment = .center
        badgeLabel.isHidden = true
        return badgeLabel
    }()
    
    var badge: String? {
        didSet {
            if badge == nil {
                badgeLabel.text = ""
                badgeLabel.isHidden = true
            } else {
                var textWidth: CGFloat = badgeWidth
                badgeLabel.isHidden = false
                if badge!.isEmpty {
                    badgeLabel.frame.size = CGSize(width: badgeDotWidth, height: badgeDotWidth)
                    badgeLabel.layer.cornerRadius = badgeDotWidth/2
                } else {
                    if Int(badge ?? "0") ?? 0 >  99 {
                        textWidth = badgeMaxWidth
                    }
                    badgeLabel.text = badge
                    badgeLabel.frame.size = CGSize(width: textWidth, height: badgeWidth)
                    badgeLabel.layer.cornerRadius = badgeWidth/2
                }
            }
        }
    }
    
    private var isCurrent: Bool = false
    open var index: Int = 0
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                itemImage.image = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
                titleLabel.textColor = titleSelectedColor
                badge = nil
                if !isCurrent {
                    addAnimation()
                }
            } else {
                titleLabel.textColor = titleNormalColor
                itemImage.image = UIImage(named: normalImage)?.withRenderingMode(.alwaysOriginal)
            }
            isCurrent = isSelected
        }
    }
    
    private var itemConfig: HNTabBarItemConfig {
        didSet {
            title = itemConfig.title
            normalImage = itemConfig.normalImage
            selectedImage = itemConfig.selectedImage
            titleSelectedColor = itemConfig.selectedTitleColor
            titleNormalColor = itemConfig.normalTitleColor
        }
    }
    
    required init(frame: CGRect, itemConfig: HNTabBarItemConfig) {
        self.itemConfig = itemConfig
        super.init(frame: frame)
        title = itemConfig.title
        normalImage = itemConfig.normalImage
        selectedImage = itemConfig.selectedImage
        titleSelectedColor = itemConfig.selectedTitleColor
        titleNormalColor = itemConfig.normalTitleColor
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(self.itemImage)
        addSubview(self.titleLabel)
        addSubview(self.badgeLabel)
        
        itemImage.image = UIImage(named: self.itemConfig.normalImage)
        itemImage.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        itemImage.center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        titleLabel.text = self.itemConfig.title
        titleLabel.frame = CGRect(x: 0, y: itemImage.frame.maxY + 1, width: self.bounds.width, height: 10)
        badgeLabel.frame = CGRect(x: 0, y: 0, width: 12, height: 12)
        badgeLabel.center = CGPoint(x: itemImage.frame.maxX, y: itemImage.frame.minY)
    }
    
    func addAnimation() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "transform.scale"
        animation.values = [1.0, 1.3, 0.9, 1.15, 0.95, 1.02, 1.0]
        animation.duration = 0.6
        animation.calculationMode = CAAnimationCalculationMode.cubic
        self.layer.add(animation, forKey: nil)
    }
}
