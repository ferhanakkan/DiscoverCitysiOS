//
//  CityViewModel.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 6.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit

struct CityViewModel {
    
    var cityModel = CityModel()
    
    mutating func setCity() {
        cityModel.city.append("Istanbul")
        cityModel.city.append("Ankara")
    }
    
    mutating func weatherUIViewSetter(weather: WeatherModel) -> UIView {
        let navView = UIView()
        let label = UILabel()
        label.text = "\(weather.cityName): \(weather.temperatureString)°C"
        label.sizeToFit()
        label.center = navView.center
        label.textAlignment = NSTextAlignment.center
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
}
