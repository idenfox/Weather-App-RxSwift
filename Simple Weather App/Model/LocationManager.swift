//
//  LocationManager.swift
//  Simple Weather App
//
//  Created by Renzo Paul Chamorro on 18/04/21.
//

import CoreLocation
import RxSwift
import RxRelay

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    
    var currentLocationRelay: BehaviorRelay<LocationModel> = BehaviorRelay(value: LocationModel(latitude: 0, Longitude: 0))
    lazy var currentLocation: Observable<LocationModel> = self.currentLocationRelay.asObservable().share(replay: 1, scope: .forever)
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        lastKnownLocation = locations.first?.coordinate
//        location.latitude = lastKnownLocation!.latitude
//        location.Longitude = lastKnownLocation!.longitude
//        print(location)
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
        let lat = lastKnownLocation!.latitude
        let lon = lastKnownLocation!.longitude
        let newLocation = LocationModel(latitude: lat, Longitude: lon)
        print(newLocation)
        currentLocationRelay.accept(newLocation)
    }
    
}
