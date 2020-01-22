//
//  MapsViewModel.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 7.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import MapKit

struct MapsViewModel {
    
    var mapsModel = MapsModel()
    var mapDrawer = MapDrawer()
}
//MARK: - Destination-CurrenLocation Settings
extension MapsViewModel {
    
    mutating func setCurrentLongitude(longitude: Double) {
        mapsModel.currentLongitude = longitude
    }
    
    mutating func setCurrentLatitude(latitude: Double) {
        mapsModel.currentLatitude = latitude
    }
    
    mutating func setDestination() {
        mapsModel.destinationLatitude = SingletonGameManager.shared.selectedAreaModel?.areaLatitude
        mapsModel.destinationLongitude = SingletonGameManager.shared.selectedAreaModel?.areaLongitude
    }
    
    func getdestinationLatitude() -> Double {
        return mapsModel.destinationLatitude!
    }
    
    func getdestinationlongitude() -> Double {
        return mapsModel.destinationLongitude!
    }
    
    func getdestinationAreaName() -> String {
        return ("Destination: \(SingletonGameManager.shared.selectedAreaModel!.areaName)")
    }
    
    mutating func setRepeatDefender() {
        mapsModel.repeatShowDefender = true
    }
    
}
//MARK: - MAPKIT
extension MapsViewModel {
    
    func mapViewRanderer(overlay: MKOverlay) -> MKPolylineRenderer {
        return mapDrawer.mapViewRanderer(overlay: overlay)
    }
    
    func getSourceLocationnAnotations() -> MKPointAnnotation{
        return mapDrawer.getSourceLocationnAnotations(currentLatitude: mapsModel.currentLatitude!, currentLongitude: mapsModel.currentLongitude!)
    }
    
    func getDestinationLocationAnnotations()  -> MKPointAnnotation {
        return mapDrawer.getDestinationLocationAnnotations(destinationLatitude: mapsModel.destinationLatitude!, destinationLongitude: mapsModel.destinationLongitude!)
    }
    
    func getDirection() -> MKDirections {
        return mapDrawer.getDirection(currentLatitude: mapsModel.currentLatitude!, currentLongitude: mapsModel.currentLongitude!, destinationLatitude: mapsModel.destinationLatitude!, destinationLongitude: mapsModel.destinationLongitude!)
    }
    
    func setRegion() -> MKCoordinateRegion {
        return mapDrawer.setRegion(currentLatitude: mapsModel.currentLatitude!, currentLongitude: mapsModel.currentLongitude!)
    }
    
    mutating func draw() -> Bool {
        if mapsModel.drawController {
            mapsModel.drawController = false
            return  true
        }
        return false
    }
}
//MARK: - ScreenSelector
extension MapsViewModel {
    
    mutating func chechDidArive(owner: Any) -> Bool {
        if (mapsModel.currentLatitude!) >= (mapsModel.destinationLatitude!-0.0005) && mapsModel.currentLatitude! <= (mapsModel.destinationLatitude!+0.0005) && mapsModel.currentLongitude! >= (mapsModel.destinationLongitude!-0.0005) && mapsModel.currentLongitude! <= (mapsModel.destinationLongitude!+0.0005) {
            if mapsModel.repeatShowDefender {
                if let toHistory = Bundle.main.loadNibNamed(K.history, owner: owner, options: nil)?.first  as? HistoryController {
                    (owner as AnyObject).navigationController?.show(toHistory, sender: nil)
                }
                mapsModel.repeatShowDefender = false
                return true
            }
        }
        return false
    }
    
}

