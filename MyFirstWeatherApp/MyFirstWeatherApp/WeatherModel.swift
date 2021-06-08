//
//  WeatherModel.swift
//  MyFirstWeatherApp
//
//  Created by AppleLab on 05/05/2021.
//

import Foundation

let WEATHER_STATES: [String:String] = [
    "sn":"Snow",
    "t":"Thunderstorm",
    "hr":"Heavy Rain",
    "lr":"Light Rain",
    "s":"Showers",
    "hc":"Heavy Cloud",
    "lc":"Light Cloud",
    "c":"Clear"]

struct WeatherModel{
    
    var records: Array<WeatherRecord> = []
    
    init(cities: Dictionary<String,String>){
        records = Array<WeatherRecord>()
        for (woeID, cityName) in cities{
           let weatherState = WEATHER_STATES.keys.randomElement()!
            records.append(WeatherRecord(woeID:woeID, cityName:cityName, weatherState:weatherState))
        }
    }
    
    struct WeatherRecord: Identifiable{
        var id: UUID = UUID()
        var woeID: String
        var cityName:String
        var longitude: Double = 1.0
        var latitutde: Double = 1.0
        var weatherState:String
        var temp:Double = Double.random(in: -2.0 ... 30.0)
        var humidity:Double = Double.random(in: 0 ... 100.0)
        var windSpeed:Double = Double.random(in: 0 ... 50.0)
        var windDirection:Double = Double.random(in: 0 ..< 360)
        
    }
    
    /*mutating func refresh(record: WeatherRecord){
        let index = records.firstIndex(where: {$0.id == record.id})
        
        records[index!].temp = Double.random(in:-10.0...30.0)
        records[index!].humidity = Double.random(in:0...100)
        records[index!].weatherState = WEATHER_STATES.values.randomElement()!
        records[index!].windSpeed = Double.random(in:0...15)
        records[index!].windDirection = Double.random(in:0..<360)
        
        print("Refreshing \(record)")
    }*/
    
    mutating func refreshProperly(woeID:String, response: MetaWeatherResponse){
        var index: Int = -1
        for (ind,rec) in records.enumerated(){
            if rec.woeID == woeID{
                index = ind
            }
        }
        print("index: \(index)")
        records[index].latitutde = Double(response.lattLong.components(separatedBy: ",")[0].trimmingCharacters(in: .whitespaces))!
        print(response.lattLong.components(separatedBy: ","))
        records[index].longitude = Double(response.lattLong.components(separatedBy: ",")[1].trimmingCharacters(in: .whitespaces))!
        records[index].weatherState = response.consolidatedWeather[0].weatherStateAbbr
        records[index].temp = response.consolidatedWeather[0].theTemp
        //records[index].temp = Double.random(in:-10.0...30.0)
        records[index].humidity = Double(response.consolidatedWeather[0].humidity)
        records[index].windSpeed = response.consolidatedWeather[0].windSpeed
        records[index].windDirection = response.consolidatedWeather[0].windDirection
        print("refreshProperly of record: \(records[index])")
    }
}
