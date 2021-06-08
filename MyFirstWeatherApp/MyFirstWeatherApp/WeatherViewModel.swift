//
//  WeatherViewModel.swift
//  MyFirstWeatherApp
//
//  Created by AppleLab on 06/05/2021.
//

import Foundation
import CoreLocation
import Combine

class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    @Published private(set) var model: WeatherModel = WeatherModel( cities: [
                                                                        "523920":"Warsaw",
                                                                        "615702":"Paris",
                                                                        "638242":"Berlin",
                                                                        "753692":"Barcelona",
                                                                        "721943":"Rome",
                                                                        "44418":"London",
                                                                        "766273":"Madrid",
                                                                        "2459115":"New York",
                                                                        "26734":"Liverpool",
                                                                        "551801":"Vienna",
                                                                        "839722":"Sofia",
                                                                        "946738":"Athens",
                                                                        "2151330":"Beijing"])
    
    var records: Array<WeatherModel.WeatherRecord>{
        model.records
    }
    
    private var cancellables: Set<AnyCancellable> = []
    private var fetcher: MetaWeatherFetcher
    private let locationManager: CLLocationManager
    @Published var currentLocation: CLLocation?
    @Published var currentLocName: String = "City Name"
    
    func fetchWeather(forId woeid: String){
            fetcher.forecast(forId: woeid)
                .sink(receiveCompletion: {completion in
                }, receiveValue: { value in
                    self.model.refreshProperly(woeID: woeid, response: value)
                })
                .store(in: &cancellables)
    }
    
    override init(){
        locationManager = CLLocationManager()
        fetcher = MetaWeatherFetcher()
        super.init()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        
        for record in records{
            refresh(record: record)
        }
        print("current location \(String(describing: currentLocation))")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        currentLocation = locations.last
        let geocoder = CLGeocoder()
        if let location = currentLocation{
            geocoder.reverseGeocodeLocation(location){
                placemarks, error in
                self.currentLocName = placemarks![0].locality!
            }
            
        }
    }
    func refresh(record: WeatherModel.WeatherRecord){
        // objectWillChange.send()
        // model.refresh(record: record)
        fetchWeather(forId: record.woeID)
    }
    
    func getProperIcon(record: WeatherModel.WeatherRecord)->String{
        
        switch record.weatherState{
        case "sn":
            return "❄️"
        case "t":
            return "🌪"
        case "hr":
            return "🌧"
        case "lr":
            return "💦"
        case "s":
            return "💧"
        case "hc":
            return "☁️"
        case "lc":
            return "🌫"
        case "c":
            return "☀️"
        default:
            return "☘️"
        }
    }
}
