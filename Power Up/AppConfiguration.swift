//
//  AppConfiguration.swift
//  Power Up
//
//  Created by Guled  on 3/15/17.
//  Copyright © 2017 Somnibyte. All rights reserved.
//

import Foundation
import UIKit

class AppConfiguration {

    /// Tint color configuration for a page indicator of a UIPageControl
    static let pageIndicatorTintColor: UIColor = UIColor.lightGray

    /// Tint color configuration for a current page indicator of a UIPageControl
    static let currentPageIndicatorTintColor: UIColor = UIColor.white

    /// Background color for UIPageControl 
    static let uiPageControlBackgroundColor: UIColor = UIColor.clear

    /// Indicates whether the status bar will be hidden or not
    static let statusBarRemainsHidden: Bool = false

    /// Customizable black color configuration 
    class func black(_ alpha: CGFloat = 1) -> UIColor {
        return UIColor.black.withAlphaComponent(alpha)
    }

}
