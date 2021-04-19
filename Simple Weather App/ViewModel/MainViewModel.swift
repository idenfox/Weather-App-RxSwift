//
//  MainViewModel.swift
//  Simple Weather App
//
//  Created by Renzo Paul Chamorro on 18/04/21.
//

import Foundation
import RxSwift
import CoreLocation

class MainViewModel {
    
    private var weatherManager = WeatherManager()
    private var locationManager = LocationManager()
    
    func fetchWeather(cityName: String) -> Observable<WeatherModel>{
        let urlString = "\(K.apiBaseUrlString)&q=\(cityName)"
        return weatherManager.performRequest(with: urlString)
    }
    func fetchWeather(latitude: Double, longitude: Double) -> Observable<WeatherModel> {
        let urlString = "\(K.apiBaseUrlString)&lat=\(latitude)&lon=\(longitude)"
        return weatherManager.performRequest(with: urlString)
    }
    func fetchLocation() -> Observable<LocationModel> {
        locationManager.start()
        return locationManager.currentLocation
    }

}
