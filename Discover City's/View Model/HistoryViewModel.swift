//
//  HistoryViewModel.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 7.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

struct HistoryViewModel {
    
    func getHistoryImage() -> String {
        return SingletonGameManager.shared.selectedAreaModel!.areaPhoto
    }
    
    func getHistoryLabel() -> String{
        return SingletonGameManager.shared.selectedAreaModel!.areaHistory
    }
    
    func toQuestion(owner: Any) {
        if let toQuestion = Bundle.main.loadNibNamed(K.question, owner: owner, options: nil)?.first  as? QuestionController {
            (owner as AnyObject).navigationController?.show(toQuestion, sender: nil)
        }
    }
}
