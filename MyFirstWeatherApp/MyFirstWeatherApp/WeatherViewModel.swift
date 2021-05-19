//
//  WeatherViewModel.swift
//  MyFirstWeatherApp
//
//  Created by AppleLab on 06/05/2021.
//

import Foundation

class WeatherViewModel: ObservableObject{
    
    @Published private(set) var model: WeatherModel = WeatherModel( cities: ["Warsaw", "Paris", "Berlin", "Barcelona","Rome","London","Madrid","New York", "Liverpool", "Vienna", "Sofia", "Athens", "Beijing"])
    
    var records: Array<WeatherModel.WeatherRecord>{
        model.records
    }
    
    func refresh(record: WeatherModel.WeatherRecord){
        // objectWillChange.send()
        model.refresh(record: record)
    }
    
    func getProperIcon(record: WeatherModel.WeatherRecord)->String{
        
        switch record.weatherState{
        case "Snow":
            return "❄️"
        case "Hail":
            return "🌨"
        case "Thunderstorm":
            return "🌪"
        case "Heavy Rain":
            return "🌧"
        case "Light Rain":
            return "💦"
        case "Showers":
            return "💧"
        case "Heavy Cloud":
            return "☁️"
        case "Light Cloud":
            return "🌫"
        case "Clear":
            return "☀️"
        default:
            return "☘️"
        }
    }
}
