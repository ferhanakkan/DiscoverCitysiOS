//
//  ScoreController.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 5.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import CLTypingLabel

class ScoreController: UIViewController {

    @IBOutlet weak var scoreScreenLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationController()
        scoreScreenLabel.text = SingletonGameManager.shared.calculateScore()
        SingletonGameManager.shared.overTimer()
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        if sender.currentTitle == "Exit" {
            exit(0)
        } else {
            SingletonGameManager.shared.resetScore()
            SingletonGameManager.shared.resetTime()
            SingletonGameManager.shared.repeatControlerForScreenPass = true
             view.window?.rootViewController = CreateNavigationController.createNavigatonController(owner: self)
        }
    }
    
}

//MARK: - SetNavigationController

extension ScoreController {
    func setNavigationController() {
        navigationItem.hidesBackButton = true
        navigationItem.titleView = SingletonGameManager.shared.weatherUIView
    }
}
