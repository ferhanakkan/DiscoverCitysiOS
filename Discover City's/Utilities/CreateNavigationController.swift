//
//  CreateNavigationController.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 7.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

class CreateNavigationController {
    
    class func createNavigatonController(owner: Any) -> UINavigationController{
        let navigationController = UINavigationController()
//         navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.backgroundColor = UIColor.init(red: 15/255, green: 76/255, blue: 184/255, alpha: 1.0)
       
        
        let appStartPoint = Bundle.main.loadNibNamed("WelcomeController", owner: owner, options: nil)?.first as! WelcomeController
        navigationController.setViewControllers([appStartPoint], animated: true)
        return navigationController
    }
}

