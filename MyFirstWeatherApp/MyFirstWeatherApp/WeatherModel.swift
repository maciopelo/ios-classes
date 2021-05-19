//
//  WeatherModel.swift
//  MyFirstWeatherApp
//
//  Created by AppleLab on 05/05/2021.
//

import Foundation

let WEATHER_STATES = ["Snow","Sleet","Hail","Thunderstorm","Heavy Rain","Light Rain","Showers","Heavy Cloud","Light Cloud","Clear"]

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
        var weatherState:String = WEATHER_STATES.randomElement()!
        var temp:Float = Float.random(in: -2.0 ... 30.0)
        var humidity:Float = Float.random(in: 0 ... 100.0)
        var windSpeed:Float = Float.random(in: 0 ... 50.0)
        var windDirection:Float = Float.random(in: 0 ..< 360)
        
    }
    
    mutating func refresh(record: WeatherRecord){
        let index = records.firstIndex(where: {$0.id == record.id})
        
        records[index!].temp = Float.random(in:-10.0...30.0)
        records[index!].humidity = Float.random(in:0...100)
        records[index!].weatherState = WEATHER_STATES.randomElement()!
        records[index!].windSpeed = Float.random(in:0...15)
        records[index!].windDirection = Float.random(in:0..<360)
        
        print("Refreshing \(record)")
    }
    
}
