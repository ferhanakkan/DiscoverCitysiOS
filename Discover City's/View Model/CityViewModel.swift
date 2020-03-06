//
//  CityViewModel.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 6.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

class CityViewModel {
    
    var cityModel: [CityModel] = []
    
    var firebase = FirestormManager()
    
    func setCity(completion: @escaping(Bool)->Void) {
        firebase.getCity(completion: { (data) in
            self.cityModel = data
            print(data)
            completion(true)
        })
    }
    
}
