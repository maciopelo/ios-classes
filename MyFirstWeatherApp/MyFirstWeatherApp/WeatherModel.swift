//
//  WeatherModel.swift
//  MyFirstWeatherApp
//
//  Created by AppleLab on 05/05/2021.
//

import Foundation

struct WeatherModel{
    
    var records: Array<WeatherRecord> = []
    
    init(cities: Array<String>){
        records = Array<WeatherRecord>()
        for city in cities{
            records.append(WeatherRecord(cityName:city))
        }
    }
    
    struct WeatherRecord: Identifiable{
        var id: UUID = UUID()
        var cityName:String
        var weatherState:String = "Windy"
        var temp:Float = Float.random(in: -2.0 ... 30.0)
        var humidity:Float = Float.random(in: 0 ... 100.0)
        var windSpeed:Float = Float.random(in: 0 ... 50.0)
        var windDirection:Float = Float.random(in: 0 ..< 360)
        
    }
    
    func refresh(record: WeatherRecord){
        print("Refreshing \(record)")
    }
    
}
