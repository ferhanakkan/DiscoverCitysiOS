//
//  AreaDataModel.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 6.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

struct AreaDataModel {
    
    var areaName: String
    var areaLatitude: Double
    var areaLongitude: Double
    var areaPhoto: String
    var areaHistory: String
    var areaQuestion: String
    var areaAnswerA: String
    var areaAnswerB: String
    var areaAnswerC: String
    var areaAnswerD: String
    var areaAnswer: String
    var point: Int
    
    init(areaName: String , areaLatitude: Double , areaLongitude: Double , areaPhoto: String , areaHistory: String , areaQuesiton: String , areaAnswerA: String , areaAnswerB: String , areaAnswerC: String , areaAnswerD: String , areaAnswer: String, point: Int) {
        self.areaName = areaName
        self.areaLatitude = areaLatitude
        self.areaLongitude = areaLongitude
        self.areaPhoto = areaPhoto
        self.areaHistory = areaHistory
        self.areaQuestion = areaQuesiton
        self.areaAnswerA = areaAnswerA
        self.areaAnswerB = areaAnswerB
        self.areaAnswerC = areaAnswerC
        self.areaAnswerD = areaAnswerD
        self.areaAnswer = areaAnswer
        self.point = point
    }
    
}

struct AreaList {
    var area: String
}
