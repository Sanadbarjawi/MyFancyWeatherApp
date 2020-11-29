//
//  UIScrollViewExtension.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 29/11/2020.
//

import UIKit

extension UIScrollView {

    func addPulltoRefreshControl(controller: UIViewController, shouldIncludeSafeArea: Bool = false,doing action: Selector,with attributedString: NSAttributedString? = nil, tintColor: UIColor? = nil) {

        let safeTop: CGFloat = UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(controller, action: action, for: .valueChanged)
        refreshControl.attributedTitle = attributedString
        refreshControl.tintColor = tintColor
        self.refreshControl = refreshControl

        if shouldIncludeSafeArea {
            self.refreshControl?.bounds = refreshControl.bounds.offsetBy(dx: 0, dy: -safeTop)
        }
        //the below line does fix the refresh control first load (on first load the tint color wont be applied)
        self.setContentOffset(CGPoint(x: 0, y: -(self.refreshControl?.frame.size.height)!), animated: false)
    }

    func beginRefreshing() {
        self.refreshControl?.beginRefreshing()
    }

    func endRefreshing() {
        self.refreshControl?.endRefreshing()
    }
}
