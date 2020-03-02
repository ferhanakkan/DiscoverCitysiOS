//
//  UIApplication.swift
//  DiscoverCity
//
//  Created by Ferhan Akkan on 2.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

extension UIApplication{
    class func getPresentedViewController() -> UIViewController? {
        
        var presentViewController = UIApplication.shared.keyWindow?.rootViewController
        while let pVC = presentViewController?.presentedViewController
        {
            presentViewController = pVC
        }
        
        return presentViewController
    }
}
