//
//  WeatherManager.swift
//  Simple Weather App
//
//  Created by Renzo Paul Chamorro on 18/04/21.
//

import Foundation
import RxSwift

class WeatherManager: ObservableObject {

    func performRequest(with url: String) -> Observable<WeatherModel> {
        
        return Observable.create { observer in
            let session = URLSession(configuration: .default)
            if let url = URL(string: url) {
                let task = session.dataTask(with: url) { (data, _, error) in
                    if error != nil {
                        print("error al obtener datos de url: \(error as Any)")
                    } else {
                        let decoder = JSONDecoder()
                        if let safeData = data {
                            do {
                                let results = try decoder.decode(WeatherResults.self, from: safeData)
                                let name = results.name
                                let temp = results.main.temp
                                let conditionId = results.weather[0].id
                                let resultWeather = WeatherModel(cityName: name, temperature: temp, conditionID: conditionId)
                                observer.onNext(resultWeather)
                            } catch {
                                observer.onError(error)
                                print("error al decodificar JSON: \(error as Any)")
                            }
                        }
                    }
                    observer.onCompleted()
                }
                task.resume()
            }
            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
    }
}
