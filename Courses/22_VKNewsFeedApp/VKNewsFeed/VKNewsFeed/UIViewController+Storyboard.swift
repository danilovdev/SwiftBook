//
//  UIViewController+Storyboard.swift
//  VKNewsFeed
//
//  Created by Alexey Danilov on 8/16/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("No initial View Controller in \(name) storyboard")
        }
    }
}
