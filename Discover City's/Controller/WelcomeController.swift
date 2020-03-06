//
//  WelcomeController.swift
//  DiscoverCity
//
//  Created by Ferhan Akkan on 28.02.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import StoreKit
import CoreLocation

class WelcomeController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var automaticSelectionView: UIView!
    @IBOutlet weak var manualySelectionView: UIView!
    @IBOutlet weak var howToPlayView: UIView!
    @IBOutlet weak var scoreBoardView: UIView!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var donateUsView: UIView!
    
    var welcomeViewModel = WelcomeViewModel()
    var locationManager = CLLocationManager()
    var weatherManager = WeatherManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingView.show()
        setCLLocationManager()
        setWeatherManager()
        setGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SingletonGameManager.shared.selectedCity = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       firstSetter()
    }
    
    private func firstSetter() {
        guard let _ =  UserDefaults.standard.value(forKey: "firstTime") else {
                if let vc = Bundle.main.loadNibNamed("NickNameController", owner: self, options: nil)?.first as? NickNameController {
                    print("vc icerisi")
                vc.modalPresentationStyle = .overFullScreen
                UIApplication.getPresentedViewController()!.present(vc, animated: true)
                    UserDefaults.standard.setValue(false, forKey: "firstTime")

            }
            return
        }
    }
    
    private func setGesture() {
        mainView.cornerRadius = 20
        automaticSelectionView.cornerRadius = automaticSelectionView.frame.width/2
        manualySelectionView.cornerRadius = manualySelectionView.frame.width/2
        howToPlayView.cornerRadius = 15
        scoreBoardView.cornerRadius = 15
        rateView.cornerRadius = 15
        donateUsView.cornerRadius = 15
        
        let myColor = UIColor.rouge
        
        automaticSelectionView.layer.borderWidth = 3.0
        automaticSelectionView.layer.borderColor = myColor.cgColor
        manualySelectionView.layer.borderWidth = 3.0
        manualySelectionView.layer.borderColor = myColor.cgColor
        howToPlayView.layer.borderWidth = 3.0
        howToPlayView.layer.borderColor = myColor.cgColor
        scoreBoardView.layer.borderWidth = 3.0
        scoreBoardView.layer.borderColor = myColor.cgColor
        rateView.layer.borderWidth = 3.0
        rateView.layer.borderColor = myColor.cgColor
        donateUsView.layer.borderWidth = 3.0
        donateUsView.layer.borderColor = myColor.cgColor
        
        
        automaticSelectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(automaticSelection)))
        manualySelectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(manualySelection)))
        howToPlayView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(howToPlaySelection)))
        scoreBoardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scoreBoardSelection)))
        rateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rateSelection)))
        
        donateUsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(donateSelection)))
    }
    
    @objc private func automaticSelection(){
        welcomeViewModel.setCity { (_) in
            LoadingView.hide()
            if (SingletonGameManager.shared.selectedCity != nil) {
                if let vc = Bundle.main.loadNibNamed("AreaController", owner: self, options: nil)?.first  as? AreaController {
                    self.navigationController?.show(vc, sender: nil)
                }
            } else {
                let alert = UIAlertController(title: "Your are not in Historical Game Are!", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
                    
                }))
                UIApplication.getPresentedViewController()!.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc private func manualySelection(){
        if let vc = Bundle.main.loadNibNamed("CityController", owner: self, options: nil)?.first  as? CityController {
            LoadingView.show()
            self.navigationController?.show(vc, sender: nil)            
        }
    }
    
    @objc private func howToPlaySelection(){
        if let vc = Bundle.main.loadNibNamed("HowToController", owner: self, options: nil)?.first  as? HowToController {
            vc.modalPresentationStyle = .overFullScreen
            UIApplication.getPresentedViewController()!.present(vc, animated: true)
            
        }
    }
    
    @objc private func scoreBoardSelection(){
        if let vc = Bundle.main.loadNibNamed("ScoreBoardController", owner: self, options: nil)?.first as? ScoreBoardController {
            LoadingView.show()
            navigationController?.show(vc, sender: nil)
        }
    }
    @objc private func rateSelection(){
        SKStoreReviewController.requestReview()
    }
    
    @objc private func donateSelection(){
             if let vc = Bundle.main.loadNibNamed("DonateController", owner: self, options: nil)?.first  as? DonateController {
               vc.modalPresentationStyle = .overFullScreen
               UIApplication.getPresentedViewController()!.present(vc, animated: true)
               
           }
    }
}


//MARK: - CLLocationManagerDelegate

extension WelcomeController: CLLocationManagerDelegate {
    
    func setCLLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async {
            SingletonGameManager.shared.userLocation = locations[0]
            self.weatherManager.fetchWeather(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

//MARK: - WeatherManagerDelegate

extension WelcomeController: WeatherManagerDelegate {
    
    func setWeatherManager() {
        weatherManager.delegate = self
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.navigationItem.titleView = self.welcomeViewModel.weatherUIViewSetter(weather: weather)
            self.locationManager.stopUpdatingLocation()
            self.setNavigationController()
            LoadingView.hide()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func setNavigationController() {
        navigationItem.titleView = SingletonGameManager.shared.weatherUIView
    }
    
    
}
