//
//  WelcomeController.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 5.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import CoreLocation
import CLTypingLabel

class CityController: UIViewController {
    @IBOutlet weak var textLabel: CLTypingLabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var cityViewModel = CityViewModel()
    var locationManager = CLLocationManager()
    var weatherManager = WeatherManager()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        cityViewModel.setCity()
        setCLLocationManager()
        setWeatherManager()
        textLabel.charInterval = 0.05
        textLabel.text = K.cityLabel
    }
}
//MARK: - TableViewDelegate

extension CityController: UITableViewDelegate, UITableViewDataSource {
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  cityViewModel.cityModel.city.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.textColor = UIColor.init(red: 223/255, green: 133/255, blue: 67/255, alpha: 1)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = cityViewModel.cityModel.city[indexPath.row]
        return  cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SingletonGameManager.shared.setSelectedCity(selectedCity: cityViewModel.cityModel.city[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        if let toArea = Bundle.main.loadNibNamed(K.area, owner: self, options: nil)?.first as? AreaController {
            self.navigationController?.show(toArea, sender: nil)
        }
    }
    
}

//MARK: - CLLocationManagerDelegate

extension CityController: CLLocationManagerDelegate {
    
    func setCLLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async {
            self.weatherManager.fetchWeather(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

//MARK: - WeatherManagerDelegate

extension CityController: WeatherManagerDelegate {
    
    func setWeatherManager() {
        weatherManager.delegate = self
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.navigationItem.titleView = self.cityViewModel.weatherUIViewSetter(weather: weather)
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
