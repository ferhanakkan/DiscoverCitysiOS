//
//  ScoreController.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 5.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

class ScoreController: UIViewController {

    @IBOutlet weak var exitButtonOutlet: UIButton!
    @IBOutlet weak var retryButtonOutlet: UIButton!
    
    @IBOutlet weak var scoreScreenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationController()
         scoreScreenLabel.setTextWithTypeAnimation(typedText: SingletonGameManager.shared.calculateScore(), characterDelay:  5)
        SingletonGameManager.shared.overTimer()
        setButtonOutlet()
        
        if (UserDefaults.standard.value(forKey: "nicknamePreferance") as! Bool) {
            SingletonGameManager.shared.setBestScore(nickname: UserDefaults.standard.value(forKey: "UserNickName") as! String, areaName: SingletonGameManager.shared.selectedArea!, point: SingletonGameManager.shared.calculateScoreInt())
        }
    }
    
    func setButtonOutlet() {
        exitButtonOutlet.cornerRadius = 15
        retryButtonOutlet.cornerRadius = 15
        let myColor = UIColor.rouge
        retryButtonOutlet.layer.borderWidth = 3.0
        retryButtonOutlet.layer.borderColor = myColor.cgColor
        exitButtonOutlet.layer.borderWidth = 3.0
        exitButtonOutlet.layer.borderColor = myColor.cgColor
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
