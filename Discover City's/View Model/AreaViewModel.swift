//
//  AreaViewModel.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 6.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//
import UIKit

class AreaViewModel {
    
    var areaData = [AreaDataModel]()
    var areaArray = [AreaList]()
    
    
//MARK: - Timer Setting
    
    func setTimer() {
        SingletonGameManager.shared.startTimer()
    }
    
    func startGame(owner: Any, data: [AreaDataModel]) {
        if SingletonGameManager.shared.repeatControlerForScreenPass {
            if data.count >= 1 {
                setTimer()
                SingletonGameManager.shared.setDataFromArray(data: data)
                
                if let toMap = Bundle.main.loadNibNamed(K.maps, owner: owner, options: nil)?.first as? MapsController {
                    (owner as AnyObject).navigationController?.show(toMap, sender: nil)
                }
                SingletonGameManager.shared.repeatControlerForScreenPass = false
            } else {
                (owner as AnyObject).present(SingletonGameManager.shared.makeAlert(title: "Please Check Your Internet Connection", message: ""), animated: true, completion: nil)
            }
        }
    }
}
 

