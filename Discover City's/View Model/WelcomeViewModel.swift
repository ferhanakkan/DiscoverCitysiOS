//
//  WelcomeViewModel.swift
//  DiscoverCity
//
//  Created by ferhan akkan on 4.03.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

struct WelcomeViewModel {
    
    var firebase = FirestormManager()
    
    mutating func weatherUIViewSetter(weather: WeatherModel) -> UIView {
        let navView = UIView()
        let label = UILabel()
        label.text = "\(weather.cityName) : \(weather.temperatureString)°C"
        label.sizeToFit()
        label.center = navView.center
        label.textAlignment = NSTextAlignment.center
        label.textColor = .white
        let image = UIImageView()
        image.image = UIImage(named: "\(weather.conditionName).png")
        let imageAspect = image.image!.size.width/image.image!.size.height
        image.frame = CGRect(x: label.frame.origin.x-label.frame.size.height*imageAspect, y: label.frame.origin.y, width: label.frame.size.height*imageAspect, height: label.frame.size.height)
        image.contentMode = UIView.ContentMode.scaleAspectFit
        navView.addSubview(label)
        navView.addSubview(image)
        navView.sizeToFit()
        
        SingletonGameManager.shared.weatherUIView = navView
        
        return navView
    }
    
    func setCity(completion: @escaping(Bool)->Void) {
        LoadingView.show()
        let userLocLong = SingletonGameManager.shared.userLocation?.coordinate.longitude
        let userLocLat = SingletonGameManager.shared.userLocation?.coordinate.latitude
        firebase.getCity(completion: { (data) in
            for i in data {
                if ((i.latitude+0.2 >= userLocLat! && i.latitude-0.2 <= userLocLat!) && ((i.longitude+0.2 >= userLocLong! && i.longitude-0.2 <= userLocLong!) )) {
                    SingletonGameManager.shared.selectedCity = i.city
                }
            }
            completion(true)
        })
    }
    
}
