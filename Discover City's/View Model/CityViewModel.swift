//
//  CityViewModel.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 6.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import CoreLocation

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
    
    func getDistance(indexpath: Int) -> String {
        let destination = CLLocation(latitude: cityModel[indexpath].latitude,longitude: cityModel[indexpath].longitude)
        let distance = SingletonGameManager.shared.userLocation!.distance(from: destination)/1000
        print("\(destination) , \(String(describing: SingletonGameManager.shared.userLocation)) ferhan destination \(distance)")
        return "(\(String(format:"%.2f", distance)) KM)"
    }
    
}
