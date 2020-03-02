//
//  MapsController.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 5.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CLTypingLabel

class MapsController: UIViewController {
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var destinationLabel: CLTypingLabel!
    @IBOutlet weak var estimetedTime: CLTypingLabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var mapsViewModel = MapsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMapview()
        setCLLocationManager()
        setNavigationBar()
        titleView.cornerRadius = 20
    }
}

//MARK: - SetNavigationBar

extension MapsController {
    
    func setNavigationBar() {
        navigationItem.hidesBackButton = true
        destinationLabel.text = mapsViewModel.getdestinationAreaName()
        navigationItem.titleView = SingletonGameManager.shared.weatherUIView
        if #available(iOS 13.0, *) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location"), style: .plain, target: self, action: #selector(findMe))
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(leaveGame))
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc func leaveGame() {
        SingletonGameManager.shared.overTimer()
        let message = SingletonGameManager.shared.leaveGame(self)
        self.present(message, animated: true)
    }
    
    @objc func findMe() {
        self.mapView.setRegion(self.mapsViewModel.setRegion(), animated: true)
    }
}

//MARK: - MapViewDelegate

extension MapsController: MKMapViewDelegate {
    
    func setMapview() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapsViewModel.setDestination()
        mapsViewModel.setRepeatDefender()
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return mapsViewModel.mapViewRanderer(overlay: overlay)
    }
    
    func drawMap() { 
        DispatchQueue.main.async {
            self.mapView.showAnnotations([self.mapsViewModel.getSourceLocationnAnotations() , self.mapsViewModel.getDestinationLocationAnnotations()], animated: true )
            
            let directions = self.mapsViewModel.getDirection()
            directions.calculate { (response, error) in
                if error != nil {
                    return
                }
                let route = response?.routes[0]
                self.mapView.addOverlay((route?.polyline)!, level: MKOverlayLevel.aboveRoads)
                let rect = route?.polyline.boundingMapRect
                self.mapView.setRegion(MKCoordinateRegion(rect!), animated: false)
                self.estimetedTime.text = "\(Int((route?.expectedTravelTime)! / 60)) minute walking distance"
                print(self.estimetedTime.text)
            }
            
            self.mapView.setRegion(self.mapsViewModel.setRegion(), animated: true)
        }
    }
}

//MARK: - CLLocationManager

extension MapsController: CLLocationManagerDelegate {
    
    func setCLLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapsViewModel.setCurrentLatitude(latitude: locations[0].coordinate.latitude)
        mapsViewModel.setCurrentLongitude(longitude: locations[0].coordinate.longitude)
        if self.mapsViewModel.chechDidArive(owner: self) {
            self.locationManager.stopUpdatingLocation()
        }
        
        if(mapsViewModel.draw()) {
            drawMap()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

