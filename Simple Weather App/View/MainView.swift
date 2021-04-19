//
//  ContentView.swift
//  Simple Weather App
//
//  Created by Renzo Paul Chamorro on 18/04/21.
//

import SwiftUI
import RxSwift

struct MainView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    private var viewModel = MainViewModel()
    private var disposeBag = DisposeBag()
    
    @State var weather = WeatherModel(cityName: "", temperature: 0, conditionID: 0)
    @State var location = LocationModel(latitude: 0, Longitude: 0)
    @State var textFieldCityName: String = ""
    
    var body: some View {
        ZStack (alignment: .topLeading){
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack (alignment: .trailing, spacing: 0) {
                HStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(colorScheme == .dark ? Color.black : Color.white)
                        .frame(height: 45)
                        .overlay(
                            TextField("Ingrese Ciudad", text: $textFieldCityName)
                            { isEditing in
                            } onCommit: {
                                getWeatherData(city: textFieldCityName.trimmingCharacters(in: .whitespacesAndNewlines))
                            }
                            .padding()
                        )
                    Button(action: {
                        getWeatherData(lat: location.latitude, long: location.Longitude)
                    }, label: {
                        Image(systemName: "location.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    })
                }
                Image(systemName: weather.conditionName)
                    .resizable()
                    .frame(width: 70, height: 70)
                    .padding(.top)
                Text(weather.temperatureString + " cº")
                    .font(Font.custom("FredokaOne-Regular", size: 120))
                Text(weather.cityName)
                    .font(Font.custom("FredokaOne-Regular", size: 30))
            }
            .padding(.all)
        }
        .onAppear(perform: {
            getLocationData()
            getWeatherData(city: "Lima")
        })
        .onTapGesture {
            self.endTextEditing()
        }
    }
    
    private func getWeatherData(city: String){
        return viewModel.fetchWeather(cityName: city)
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { weatherData in
                weather = weatherData
                print(weather)
            } onError: { (error) in
                print("error al suscribirse a fetchWeather: \(error)")
            } onCompleted: {
            }.disposed(by: disposeBag)
    }
    
    private func getWeatherData(lat: Double, long: Double){
        return viewModel.fetchWeather(latitude: lat, longitude: long)
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { weatherData in
                weather = weatherData
                print(weather)
            } onError: { (error) in
                print("error al suscribirse a fetchWeather: \(error)")
            } onCompleted: {
            }.disposed(by: disposeBag)
    }
    
    private func getLocationData() {
        return viewModel.fetchLocation()
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { locationData in
                self.location = locationData
            } onError: { (error) in
                print("error al suscribirse a fetchLocation: \(error)")
            } onCompleted: {
            }.disposed(by: disposeBag)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
