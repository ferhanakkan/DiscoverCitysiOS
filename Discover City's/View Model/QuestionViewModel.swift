//
//  QuestionController.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 7.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

struct QuestionViewModel {
    
    var doesPickerSelected = false
    
    func getQuestion() -> String{
        return SingletonGameManager.shared.selectedAreaModel!.areaQuestion
    }
    
    func getAnswerA() ->String{
        return SingletonGameManager.shared.selectedAreaModel!.areaAnswerA
    }
    
    func getAnswerB() ->String{
        return SingletonGameManager.shared.selectedAreaModel!.areaAnswerB
    }
    
    func getAnswerC() ->String{
        return SingletonGameManager.shared.selectedAreaModel!.areaAnswerC
    }
    
    func getAnswerD() ->String{
        return SingletonGameManager.shared.selectedAreaModel!.areaAnswerD
    }
    
    func getDescription() ->String {
        return "Now you are in : \(SingletonGameManager.shared.selectedAreaModel!.areaName) area. Firstly you have to take a picture than answer the question."
    }
    
//MARK: - Picker
    
    func setPicker(owner: Any) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = (owner as! UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        picker.sourceType = .camera
        picker.allowsEditing = true
        return picker
    }
    
    
//MARK: - Screen Pass
    
    mutating func screenPass(owner: Any) {
        if(SingletonGameManager.shared.arrayCounter < SingletonGameManager.shared.selectedAreaArray!.count-1){
            SingletonGameManager.shared.setNewSelectedArea()
            if let toScrore = Bundle.main.loadNibNamed(K.maps, owner: owner, options: nil)?.first  as? MapsController {
                (owner as AnyObject).navigationController?.show(toScrore, sender: nil)
            }
        } else {
            SingletonGameManager.shared.overTimer()
            if let toScrore = Bundle.main.loadNibNamed(K.score, owner: owner, options: nil)?.first  as? ScoreController {
                (owner as AnyObject).navigationController?.show(toScrore, sender: nil)
            }
        }
    }

    //MARK: - Alert Message
    mutating func makeAlertForOneTime() -> UIAlertController {
        doesPickerSelected = true
        return SingletonGameManager.shared.makeAlert(title: "Don't forget to take photo!!!", message: "If you forget you gonna lose point's")
    }
    
    //MARK: - Check Answer
    func chechAnswer(answer: String) {
        if answer == SingletonGameManager.shared.selectedAreaModel!.areaAnswer {
            SingletonGameManager.shared.scoreUP()
        }
    }
    
}
