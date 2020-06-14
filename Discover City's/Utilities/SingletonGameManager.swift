//
//  SingletonGameManager.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 6.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import CoreLocation

class SingletonGameManager {
    
    static let shared = SingletonGameManager()
    
    let reachability: Reachability = try! Reachability(hostname: "google.com")
    
    var firestorm = FirestormManager()
    
    var selectedCity: String?
    var selectedArea: String?
    
    var selectedAreaModel: AreaDataModel?
    var selectedAreaArray: [AreaDataModel]?
    var repeatControlerForScreenPass = true
    
    var score = 0
    var timeInt = 0
    var arrayCounter = 0
    
    var weatherUIView: UIView?
    var time = Timer()
    
    var userLocation : CLLocation?
}

//MARK: - Timer Settings

extension SingletonGameManager {
    func startTimer() {
        time=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeCounter), userInfo: nil, repeats: true)
    }
    
    @objc func timeCounter() {
        timeInt += 1
        print("time:\(timeInt)")
    }
    
    func overTimer() {
        time.invalidate()
    }
    
    func resetTime() {
        timeInt = 0
    }
}



//MARK: - Score Settings
extension SingletonGameManager {
    func scoreUP() {
        score += 7000
    }
    
    func resetScore() {
        score = 0
    }
    
    func calculateScore() -> String {
        return "Your Score \(score-(timeInt*3))"
    }
    
    func calculateScoreInt() -> Int {
        return score-(timeInt*3)
    }
}


//MARK: - City-Area Settings

extension SingletonGameManager {
    
    func arrayCounterUp() {
        arrayCounter += 1
    }
    
    func setSelectedCity(selectedCity: String) {
        self.selectedCity = selectedCity
    }
    
    func setSelectedArea(selectedArea: AreaDataModel) {
        self.selectedAreaModel = selectedArea
    }
    
    func getSelectedArea() -> AreaDataModel {
        return selectedAreaModel!
    }
    
    func setNewSelectedArea() {
        SingletonGameManager.shared.arrayCounterUp()
        selectedAreaModel = selectedAreaArray![arrayCounter]
    }
    
}

//MARK: - Alert Message

extension SingletonGameManager {
    func makeAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title , message: message , preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (UIAlertAction) in
        }
        alert.addAction(okButton)
        return alert
    }
    
    func leaveGame(_ owner: Any) -> UIAlertController {
        let alert = UIAlertController(title: "Do you want to leave game?" , message: "If you want to leave game press Leave , if you want to continue press Continue" , preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Leave", style: UIAlertAction.Style.default) { (UIAlertAction) in
            SingletonGameManager.shared.resetScore()
            SingletonGameManager.shared.resetTime()
            SingletonGameManager.shared.repeatControlerForScreenPass = true
            (owner as AnyObject).view.window?.rootViewController = CreateNavigationController.createNavigatonController(owner: owner)
        }
        let continueButton = UIAlertAction(title: "Continue", style: UIAlertAction.Style.default) { (UIAlertAction) in
            SingletonGameManager.shared.startTimer()
        }
        alert.addAction(okButton)
        alert.addAction(continueButton)
        return alert

    }
}

//MARK: - FireStorm

extension SingletonGameManager {
    
    func setDataFromArray(data: [AreaDataModel]) {
            selectedAreaArray = data.sorted { $0.point < $1.point }
            selectedAreaModel = selectedAreaArray![arrayCounter]
    }
    
    func setBestScore(nickname: String, areaName: String, point: Int) {
        firestorm.setBestScore(nickname: nickname , areaName: areaName, point: point) { (Bool) in
            
        }
    }
    
}

//MARK: - Reachability

extension SingletonGameManager {

     func setReachability() {
         do {
             try reachability.startNotifier()
         } catch {
             assertionFailure("Unable to start\nnotifier")
         }
        
        reachability.whenUnreachable = { reachability in
            let alert = UIAlertController(title: "Your internet connection has been lost!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: { action in
                if self.reachability.connection == .unavailable {
                    UIApplication.getPresentedViewController()!.present(alert, animated: true, completion: nil)
                }
            }))
            alert.addAction(UIAlertAction(title: "Quit", style: .default, handler: { action in
                exit(0)
            }))
            UIApplication.getPresentedViewController()!.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
}
