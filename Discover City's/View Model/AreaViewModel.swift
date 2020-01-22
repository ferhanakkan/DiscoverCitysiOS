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
    var areaArray = [String]()
    
    

    
    func setTableviewArea(selection: String) {
        if selection == "Istanbul" {
            areaArray = ["Sultan Ahmet","Eminonu"]
        } else if selection == "Ankara" {
            areaArray = ["Anitkabir", "Ankara Kalesi"]
        } else {
            areaArray = ["error","error"]
        }
    }

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
//MARK: - Create CEll
    
extension AreaViewModel {
    
    func createCell(indexPath i: Int) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.init(red: 223/255, green: 133/255, blue: 67/255, alpha: 1)
        cell.textLabel?.text = areaArray[i]
        return cell
    }
}
    

