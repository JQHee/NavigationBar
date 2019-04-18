//
//  FDNavigationBarContentView.swift
//  FOLDin
//
//  Created by Archer on 2018/12/10.
//

import UIKit

class FDNavigationBarContentView: UIView {
    
    var contentMargin = FDMargin(left: 0, right: 0) {
        didSet {
            if contentMargin != oldValue {
                setNeedsLayout()
            }
        }
    }
    
    private var navigationItem = FDNavigationItem()
    private var titleTextAttributes: [NSAttributedString.Key : Any]?
    
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.textAlignment = .center
        v.lineBreakMode = .byTruncatingTail
        v.font = .boldSystemFont(ofSize: 18)
        v.textColor = UIColor(rgbValue: 0x333333)
        addSubview(v)
        return v
    }()
    
    private lazy var leftBarStackView: FDButtonBarStackView = {
        let v = FDButtonBarStackView()
        v.layer.masksToBounds = true
        addSubview(v)
        return v
    }()
    
    private lazy var rightBarStackView: FDButtonBarStackView = {
        let v = FDButtonBarStackView()
        v.layer.masksToBounds = true
        addSubview(v)
        return v
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _layoutLeftBarStackView()
        _layoutRightBarStackView()
        _layoutNavigationTitleView()
    }
}

extension FDNavigationBarContentView {
    private func _layoutLeftBarStackView() {
        var safeAreaInsetsLeft = contentMargin.left
        if #available(iOS 11.0, *) {
            safeAreaInsetsLeft += safeAreaInsets.left
        }
        leftBarStackView.nv.top = 0
        leftBarStackView.nv.height = nv.height
        leftBarStackView.nv.left = safeAreaInsetsLeft
        if let leftBarItems = navigationItem.leftBarButtonItems, !leftBarItems.isEmpty {
            leftBarStackView.subviews.forEach { $0.removeFromSuperview() }
            var stackViewWidth: CGFloat = 0
            for (index, leftBarItem) in leftBarItems.enumerated() {
                let view = (leftBarItem.customView != nil) ? leftBarItem.customView! : leftBarItem.buttonView
                view.nv.left = stackViewWidth
                if view.nv.width <= 0 {
                    view.nv.width = view.intrinsicContentSize.width
                }
                stackViewWidth += view.nv.width
                if view.nv.height <= 0 {
                    view.nv.height = view.intrinsicContentSize.height
                }
                view.nv.centerY = leftBarStackView.nv.height / 2
                leftBarStackView.addSubview(view)
                if index + 1 < leftBarItems.count {
                    stackViewWidth += leftBarItems[index + 1].margin
                }
            }
            leftBarStackView.nv.width = stackViewWidth
            leftBarStackView.isHidden = false
        } else {
            leftBarStackView.nv.width = 0
            leftBarStackView.isHidden = true
        }
    }
    
    private func _layoutRightBarStackView() {
        var safeAreaInsetsRight = contentMargin.right
        if #available(iOS 11.0, *) {
            safeAreaInsetsRight += safeAreaInsets.right
        }
        rightBarStackView.nv.top = 0
        rightBarStackView.nv.height = nv.height
        if let rightBarButtonItems = navigationItem.rightBarButtonItems?.reversed(), !rightBarButtonItems.isEmpty {
            let rightBarItems = Array(rightBarButtonItems)
            rightBarStackView.subviews.forEach { $0.removeFromSuperview() }
            var stackViewWidth: CGFloat = 0
            for (index, rightBarItem) in rightBarItems.enumerated() {
                let view = (rightBarItem.customView != nil) ? rightBarItem.customView! : rightBarItem.buttonView
                view.nv.left = stackViewWidth
                if view.nv.width <= 0 {
                    view.nv.width = view.intrinsicContentSize.width
                }
                stackViewWidth += view.nv.width
                if view.nv.height <= 0 {
                    view.nv.height = view.intrinsicContentSize.height
                }
                view.nv.centerY = rightBarStackView.nv.height / 2
                rightBarStackView.addSubview(view)
                if index + 1 < rightBarItems.count {
                    stackViewWidth += rightBarItems[index + 1].margin
                }
            }
            rightBarStackView.isHidden = false
            rightBarStackView.nv.width = stackViewWidth
        } else {
            rightBarStackView.isHidden = true
            rightBarStackView.nv.width = 0
        }
        rightBarStackView.nv.right = nv.width - safeAreaInsetsRight
    }
    
    private func _layoutNavigationTitleView() {
        titleTextAttributesDidChange(titleTextAttributes)
        titleLabel.isHidden = navigationItem.titleView != nil
        let titleView = (navigationItem.titleView != nil) ? navigationItem.titleView! : titleLabel
        // 对于leftBarButtonItems和rightBarButtonItems肯定是要显示完全的
        // 唯一可以截断的就是titleView 在发生屏幕旋转时，因为navigationBar
        // 变长了，所以可以试着去调整titleView的大小
        if titleView.nv.width <= 0 || titleView.nv.width < titleView.intrinsicContentSize.width {
            titleView.nv.width = titleView.intrinsicContentSize.width
        }
        if titleView.nv.height <= 0 || titleView.nv.width < titleView.intrinsicContentSize.height {
            titleView.nv.height = titleView.intrinsicContentSize.height
        }
        titleView.nv.centerY = nv.height / 2
        titleView.nv.centerX = nv.width / 2
        
        // 只有当leftBarStackView没有时才不计算navigationItem.titleViewMargin.left
        let leftWidth = leftBarStackView.nv.right + (leftBarStackView.isHidden ? 0 : navigationItem.titleViewMargin.left )
        let rightOriginX = rightBarStackView.nv.left - (rightBarStackView.isHidden ? 0 : navigationItem.titleViewMargin.right)
        let rightWidth = nv.width - rightOriginX
        let remainingWidth = nv.width - leftWidth - rightWidth
        if remainingWidth >= titleView.nv.width {
            // 可以居中放置
            if titleView.nv.left >= leftWidth && titleView.nv.right <= rightOriginX {
                titleView.nv.centerX = nv.width / 2
            } else if leftWidth >= rightWidth {
                titleView.nv.left = leftWidth
            } else if rightWidth > leftWidth {
                titleView.nv.right = rightOriginX
            } else {
                debugPrint("WRANING: What")
            }
        } else {
            // 还有空间可以放titleView
            // 但是满足不了宽度要求就采取截断
            if leftWidth < rightOriginX {
                titleView.nv.width = rightOriginX - leftWidth
                titleView.nv.right = rightOriginX
            } else {
                titleView.nv.width = 0
                let extraPart = abs(rightOriginX - leftWidth)
                let appropriateValue = (extraPart - navigationItem.titleViewMargin.left - navigationItem.titleViewMargin.right + 12) / 2
                let oldLeftBarStackViewLeft = leftBarStackView.nv.left
                leftBarStackView.nv.width -= appropriateValue
                leftBarStackView.nv.left = oldLeftBarStackViewLeft
                let oldRightBarStackViewRight = rightBarStackView.nv.right
                rightBarStackView.nv.width -= appropriateValue
                rightBarStackView.nv.right = oldRightBarStackViewRight
                debugPrint("WRANING: All UI element in FDNavigationBar exceeds the width limit.")
            }
        }
    }
}

extension FDNavigationBarContentView {
    func navigationItemDidChange(_ item: FDNavigationItem) {
        layer.masksToBounds = true
        if let newTitleView = item.titleView {
            viewWithTag(999)?.removeFromSuperview()
            newTitleView.tag = 999
            addSubview(newTitleView)
        }
        navigationItem = item
        // 根据新数据重新布局
        setNeedsLayout()
    }
    
    func titleTextAttributesDidChange(_ attributes: [NSAttributedString.Key : Any]?) {
        titleTextAttributes = attributes
        guard let title = navigationItem.title else {
            titleLabel.attributedText = nil
            return
        }
        titleLabel.attributedText = NSAttributedString(string: title, attributes: attributes)
    }
}
