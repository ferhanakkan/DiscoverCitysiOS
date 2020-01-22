//
//  MapDrawer.swift
//  Discover City's
//
//  Created by Ferhan Akkan on 7.01.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import MapKit

struct MapDrawer {
    
    //MARK: - MAPKIT
    
    func mapViewRanderer(overlay: MKOverlay) -> MKPolylineRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.orange
        renderer.lineWidth = 3.0
        return renderer
    }
    
    func getSourceLocationnAnotations(currentLatitude: Double, currentLongitude: Double ) -> MKPointAnnotation{
        let sourceLocation = CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude)
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = K.startPoint
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
            return sourceAnnotation
        }
        return sourceAnnotation
    }
    
    func getDestinationLocationAnnotations(destinationLatitude: Double,destinationLongitude: Double)  -> MKPointAnnotation {
        let destinationLocation = CLLocationCoordinate2D(latitude: destinationLatitude, longitude: destinationLongitude)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = K.destination
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
            return destinationAnnotation
        }
        return destinationAnnotation
    }
    
    func getDirection(currentLatitude: Double, currentLongitude: Double, destinationLatitude: Double,destinationLongitude: Double) -> MKDirections {
        let sourceLocation = CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude)
        let destinationLocation = CLLocationCoordinate2D(latitude: destinationLatitude, longitude: destinationLongitude)
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        return directions
        
    }
    
    func setRegion(currentLatitude: Double, currentLongitude: Double ) -> MKCoordinateRegion {
        let location = CLLocationCoordinate2DMake(currentLatitude, currentLongitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        return region
    }
    
    
}
